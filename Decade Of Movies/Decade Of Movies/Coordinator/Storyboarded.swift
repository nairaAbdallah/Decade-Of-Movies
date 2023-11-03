//
//  Storyboarded.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

protocol Storyboarded {
    static func instantiate(_ storyboardName: String) -> Self?
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboardName: String = Storyboard.master) -> Self? {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: id) as? Self
    }
}
