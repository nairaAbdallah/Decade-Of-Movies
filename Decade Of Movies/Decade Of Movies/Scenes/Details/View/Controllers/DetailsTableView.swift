//
//  DetailsTableView.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailsVM.numOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsVM.getNumOfRow(for: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case detailsVM.numOfSections-1:
            setUpPictures(tableView, for: indexPath)
        default:
            setUpItem(tableView, for: indexPath)
        }
    }
    
}
// MARK: - SetUpTextItem
extension DetailsViewController {
    private func setUpItem(_ tableView: UITableView,
                                for indexPath: IndexPath)
    -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: itemId,
                                                       for: indexPath) as? DetailsItemTableViewCell
        else {
            fatalError("Cell not exists in cell")
        }
        cell.title = detailsVM.getItemByIndexPath(for: indexPath)
        return cell
    }
}
// MARK: - SetUpPictures
extension DetailsViewController {
    private func setUpPictures(_ tableView: UITableView,
                               for indexPath: IndexPath)
    -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: picturesId,
                                                       for: indexPath) as? PicturesTableViewCell
        else {
            fatalError("Cell not exists in cell")
        }
        return cell
    }
}
// MARK: - UITableViewDelegate
extension DetailsViewController: UITableViewDelegate {
    // MARK: - Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return detailsVM.heightForHeader
    }
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: headerId)
                as? MasterHeaderTableViewCell
        else {
            fatalError("Cell not exists in cell")
        }
        cell.title = detailsVM.getTitleOfHeader(for: section)
        return cell
    }
}

