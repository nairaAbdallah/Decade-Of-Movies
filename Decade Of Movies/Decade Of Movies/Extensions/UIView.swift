//
//  UIView.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    var safeAreaHeight: CGFloat {
        return safeAreaLayoutGuide.layoutFrame.size.height
    }
}

