//
//  SearchViewController.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

class SearchViewController: UIViewController, Storyboarded {
    // MARK: - Properties
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        innerNavigation(for: "Search")
    }
    
}
