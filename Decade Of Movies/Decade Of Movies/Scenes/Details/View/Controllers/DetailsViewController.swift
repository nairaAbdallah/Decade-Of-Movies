//
//  DetailsViewController.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

class DetailsViewController: UIViewController, Storyboarded {
    // MARK: - Properties
    var movie: MasterDataViewModel?
    internal lazy var detailsVM: DetailsViewModel = {
        return DetailsViewModel(delegate: self)
    }()
    // MARK: - Identifiers
    internal let headerId = MasterHeaderTableViewCell.identifier
    internal let itemId = DetailsItemTableViewCell.identifier
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        backNavBK()
        titleNav(for: "Details")
        setUpTableView()
    }
}
// MARK: - SetUp tableView
extension DetailsViewController {
    private func setUpTableView() {
        let adjustTabBar = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = adjustTabBar
        tableView.scrollIndicatorInsets = adjustTabBar
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.sectionHeaderTopPadding = 0.0
//        tableView.isHidden = true
        //MARK: - Register cells
        registerCells()
    }
    private func registerCells() {
        [headerId, itemId].forEach { id in
            tableView.register(UINib(nibName: id, bundle: nil),
                               forCellReuseIdentifier: id)
        }
    }
}
// MARK: - Implement protocol
extension DetailsViewController: DetailsProtocol {
    var moviesData: MasterDataViewModel? {
        return movie
    }
    var updateLoadingStatus: ((State) -> Void)? {
        return { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                activityIndicator(activity: indicator)
            case .empty, .error:
                indicator.stopAnimating()
            default:
                indicator.stopAnimating()
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
