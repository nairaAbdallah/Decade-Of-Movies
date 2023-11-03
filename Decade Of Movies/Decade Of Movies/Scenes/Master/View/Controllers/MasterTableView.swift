//
//  MasterTableView.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension MasterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return masterVM.numOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masterVM.getNumOfRow(for: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: masterId,
                                                       for: indexPath) as? MasterTableViewCell
        else {
            fatalError("Cell not exists in cell")
        }
        cell.moviesVM = masterVM.getCategoryByRow(for: indexPath)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension MasterViewController: UITableViewDelegate {
    // MARK: - Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return masterVM.heightForHeader
    }
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: headerId)
                as? MasterHeaderTableViewCell
        else {
            fatalError("Cell not exists in cell")
        }
        cell.title = masterVM.getTitleOfHeader(for: section)
        return cell
    }
}
