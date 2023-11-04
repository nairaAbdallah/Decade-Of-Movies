//
//  Navigation.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit

// MARK: - UIGestureRecognizerDelegate
extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func interactivePopGesture() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.view?.semanticContentAttribute = .forceLeftToRight
    }
}
// MARK: - Navigation
extension UIViewController {
    func backNavBK() {
        interactivePopGesture()
        var backBtn: UIButton {
            let back = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            back.setImage(UIImage(named: "back"), for: .normal)
            back.backgroundColor = UIColor.clear
            back.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
            return back
        }
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backBtn)]
    }
    func titleNav(for title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Avenir-Heavy", size: 16)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
    }
}
// MARK: - @objc
extension UIViewController {
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}
