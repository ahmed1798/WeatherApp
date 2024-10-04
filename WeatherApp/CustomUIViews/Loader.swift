//
//  Loader.swift
//  WeatherApp
//
//  Created by Ahmed Eissa on 04/10/2024.
//

import UIKit

protocol IndicatorProtocol: AnyObject {
    func startLoading()
    func endLoading()
}

class CustomIndicator {
    static let instance = CustomIndicator()
    
    private var boxView = UIView()
    
    private var superView:UIView!
    
    func startActivity(view:UIView, label:String) {
        // You only need to adjust this frame to move it anywhere you want
        self.boxView.removeFromSuperview() // remove redandant loaders
        self.boxView.semanticContentAttribute = .forceLeftToRight
        self.boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        self.boxView.backgroundColor = UIColor.gray
        self.boxView.alpha = 0.9
        self.boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.semanticContentAttribute = .forceLeftToRight
        textLabel.textColor = UIColor.white
        textLabel.text = label
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
        
        view.isUserInteractionEnabled = false
        
        self.superView = view
    }
    
    func endActivity() {
        if self.superView != nil {
            self.superView.isUserInteractionEnabled = true
        }
        self.boxView.removeFromSuperview()
    }

}


