//
//  UIViewInspectable.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat  {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return .clear
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            clipsToBounds = self.shadowRadius == 0.0
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var topLeftCorner: Bool {
        get {
            return cornersArr.contains(.layerMinXMinYCorner)
        }
        set {
            if newValue {
                cornersArr.insert(.layerMinXMinYCorner)
            } else {
                cornersArr.remove(.layerMinXMinYCorner)
            }
            updateCorners()
        }
    }
    
    @IBInspectable
    var bottomLeftCorner: Bool {
        get {
            return cornersArr.contains(.layerMinXMaxYCorner)
        }
        set {
            if newValue {
                cornersArr.insert(.layerMinXMaxYCorner)
            } else {
                cornersArr.remove(.layerMinXMaxYCorner)
            }
            updateCorners()
        }
    }
    
    @IBInspectable
    var topRightCorner: Bool {
        get {
            return cornersArr.contains(.layerMaxXMinYCorner)
        }
        set {
            if newValue {
                cornersArr.insert(.layerMaxXMinYCorner)
            } else {
                cornersArr.remove(.layerMaxXMinYCorner)
            }
            updateCorners()
        }
    }
    
    @IBInspectable
    var bottomRightCorner: Bool {
        get {
            return cornersArr.contains(.layerMaxXMaxYCorner)
        }
        set {
            if newValue {
                cornersArr.insert(.layerMaxXMaxYCorner)
            } else {
                cornersArr.remove(.layerMaxXMaxYCorner)
            }
            updateCorners()
        }
    }
    
    private var cornersArr: CACornerMask {
        get {
            return layer.maskedCorners
        }
        set {
            layer.maskedCorners = newValue
        }
    }
    
    private func updateCorners() {
        layer.maskedCorners = cornersArr
    }
}

