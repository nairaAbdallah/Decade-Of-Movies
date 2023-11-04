//
//  UIViewController.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    func activityIndicator(activity: NVActivityIndicatorView) {
        activity.frame = CGRect(x: UIScreen.main.bounds.width/2-20,
                                y: UIScreen.main.bounds.height/2-20,
                                width: 40, height: 40)
        activity.type = .ballScaleRippleMultiple
        activity.color = .white
        view.addSubview(activity)
        activity.startAnimating()
    }
}
