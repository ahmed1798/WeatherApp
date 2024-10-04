//
//  WeatherFiveDaysViewController.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import UIKit
import Combine

class WeatherFiveDaysViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var weatherTableView: UITableView!
    
    // MARK: Propertiesss
    let viewModel: WeatherFiveDaysViewModel
    private var filteredWeather: WeatherList = []
    private var days: Set<String> = []
    weak var coordinator: WeatherFiveDaysCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    
    init(viewModel: WeatherFiveDaysViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "WeatherFiveDaysViewController", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        filterWeatherDays()
    }
    
    //MARK: - Setup Hours Collection View
    private func setupTableView() {
        weatherTableView.registerCell(cell: WeatherFiveDaysCell.self)
        weatherTableView.setupTableView(viewController: self)
        weatherTableView.reloadData()
    }
    
    // MARK: - FILTER WEATER DAYS
    private func filterWeatherDays() {
        viewModel.$weather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weatherList in
                guard let self = self else { return }
                for weather in weatherList {
                    let dayString = "\(weather.dt ?? 0)".convertTimeIntervalDate(dt: weather.dt ?? 0)
                    
                    if !days.contains(dayString), filteredWeather.count < 5 {
                        filteredWeather.append(weather)
                        days.insert(dayString)
                    }
                }
                self.setupTableView()
            }.store(in: &anyCancellable)
    }
    
    @IBAction func backButtonTapped() {
        coordinator?.back()
    }

}

// MARK: - UITableViewDataSource
extension WeatherFiveDaysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherFiveDaysCell", for: indexPath) as? WeatherFiveDaysCell else { return WeatherFiveDaysCell() }
        cell.config(with: filteredWeather[indexPath.row])
        return cell
    }
}
