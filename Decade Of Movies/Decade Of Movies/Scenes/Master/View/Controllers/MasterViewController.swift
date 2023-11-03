//
//  MasterViewController.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

class MasterViewController: UIViewController, Storyboarded {
    // MARK: - Properties
    internal lazy var coordinator: MainCoordinator? = {
        return MainCoordinator()
    }()
    internal lazy var masterVM: MasterViewModel = {
        return MasterViewModel(delegate: self)
    }()
    // MARK: - Identifiers
    internal let headerId = MasterHeaderTableViewCell.identifier
    internal let masterId = MasterTableViewCell.identifier
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        masterVM.getMovies()
    }
}
// MARK: - SetUp tableView
extension MasterViewController {
    private func setUpTableView() {
        let adjustTabBar = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = adjustTabBar
        tableView.scrollIndicatorInsets = adjustTabBar
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.sectionHeaderTopPadding = 0.0
        tableView.isHidden = true
        //MARK: - Register cells
        registerCells()
    }
    private func registerCells() {
        [headerId, masterId].forEach { id in
            tableView.register(UINib(nibName: id, bundle: nil),
                               forCellReuseIdentifier: id)
        }
    }
}
// MARK: - Implement protocol
extension MasterViewController: MasterProtocol {
    var updateLoadingStatus: ((State) -> Void)? {
        return { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                print("")
            case .empty, .error:
                print("")
            default:
                print("")
            }
        }
    }
    var reloadTableView: ((Bool) -> Void)? {
        return { [weak self] isHidden in
            guard let self = self else { return }
            tableView.reloadData()
            tableView.isHidden = isHidden
        }
    }
}
