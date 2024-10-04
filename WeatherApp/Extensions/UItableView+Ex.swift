//
//  UItableView+Ex.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//
import UIKit

extension UITableView {
    
    // MARK: - REGISTER TABLE VIEW CELL
    func registerCell<Cell : UITableViewCell>(cell : Cell.Type){
        let nibName = String(describing: cell.self) // transform classCellName to String
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
   
    // MARK: - SETUP TABLE VIEW
    func setupTableView(viewController: UIViewController) {
        self.delegate = viewController as? any UITableViewDelegate
        self.dataSource = viewController as? any UITableViewDataSource
        self.tableFooterView = UIView()
        self.separatorInset = .zero
        self.contentInset = .zero
        self.isHidden = false
        self.separatorStyle = .singleLine
        self.showsVerticalScrollIndicator = false
    }
}
