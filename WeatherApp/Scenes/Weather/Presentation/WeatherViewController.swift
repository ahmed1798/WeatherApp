//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var weatherView: UIView!
    
    // MARK: Propertiesss
    let viewModel: WeatherViewModel
    weak var coordinator: WeatherCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    private var weather: WeatherList = []
    private let weatherCached = WeatherCache.instance
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "WeatherViewController", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindToLoader()
        bindToWeatherData()
        bindToError()
    }
    
    // MARK: - SETUP VIEWS
    private func setupViews() {
        searchTextField.delegate = self
        searchButton.isHidden = (searchTextField.text == "" && (searchTextField.text?.count ?? 0) <= 2)
    }
    
    // MARK: - SEARCH WEATHER BY CITY NAME
    private func searchWeatherByCityName() {
        guard let cityName = searchTextField.text else { return }
        if let cachedWeather = weatherCached.getWeather(for: cityName) {
            weather = cachedWeather
            updateWeatherData(with: cachedWeather)
        } else {
            viewModel.fetchWeather(cityName: cityName)
        }
        self.errorLabel.isHidden = true
    }
    
    // MARK: - UPDATE WEATHER DATA
    private func updateWeatherData(with weather: WeatherList) {
        self.weatherView.isHidden = weather.isEmpty
        self.temperatureLabel.text = "\(Int(weather.first?.main?.temp ?? 0.0))°C"
        self.humidityLabel.text = "\(weather.first?.main?.humidity ?? 0)%"
        self.windSpeedLabel.text = "\(weather.first?.wind?.speed ?? 0.0) km/h"
        self.descriptionLabel.text = weather.first?.weather?.first?.desc ?? ""
    }
    
    // MARK: - BIND TO WEATHER DATA
    private func bindToWeatherData() {
        viewModel.$weatherList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                guard let self else { return }
                self.weather = weather
                self.weatherCached.saveWeather(weather, for: searchTextField.text ?? "")
                self.updateWeatherData(with: weather)
            }.store(in: &anyCancellable)
    }
    
    // MARK: - BIND TO ERROR
    private func bindToError() {
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let self else { return }
                self.errorLabel.isHidden = false
                self.errorLabel.text = errorMessage
            }
            .store(in: &anyCancellable)
    }
    
    //: MARK: - BIND TO LOADER
    private func bindToLoader() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                isLoading ? (CustomIndicator.instance.startActivity(view: self.view, label: "Please Wait...")) : (CustomIndicator.instance.endActivity())
            }.store(in: &anyCancellable)
    }
    
    @IBAction func searchTap(_ sender: Any) {
        searchWeatherByCityName()
    }
    
    @IBAction func seeMoreWeather(_ sender: Any) {
        coordinator?.navigateToWeatherFiveDays(weather: weather)
    }
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setupViews()
    }
}
