//
//  SearchTextField.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit

// MARK: - SetUpSearch
extension SearchViewController {
    func setUpSearch() {
        searchTF.attributedPlaceholder = NSAttributedString(
            string: "Find your movie",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8666666667, green: 0.9490196078, blue: 0.9921568627, alpha: 1)]
        )
        searchTF.inputAccessoryView = UIView()
        searchTF.delegate = self
        searchTF.addTarget(self, action: #selector(textFieldDidChange(_:)),
                           for: .editingChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc func tapGestureHandler() {
        dismissKeyBoard()
    }
    private func dismissKeyBoard() {
        tableView.keyboardDismissMode = .onDrag
        view.endEditing(true)
    }
}
// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        searchVM.filterMovies(for: textField.text ?? "")
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyBoard()
        return true
    }
    
}
