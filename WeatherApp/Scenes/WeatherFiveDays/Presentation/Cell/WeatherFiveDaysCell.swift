//
//  WeatherFiveDaysCell.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import UIKit

class WeatherFiveDaysCell: UITableViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func config(with weatherData: ListModel) {
        dateLabel.text = "\(weatherData.dt ?? 0)".convertTimeIntervalDate(dt: weatherData.dt ?? 0)
        temperatureLabel.text = "\(Int(weatherData.main?.tempMin ?? 0.0))°C - \(Int(weatherData.main?.tempMax ?? 0.0))°C"
    }
}
