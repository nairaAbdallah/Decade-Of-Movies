//
//  SearchTableView.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchVM.numOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.getNumOfRow(for: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: masterId,
                                                       for: indexPath) as? SearchTableViewCell
        else {
            fatalError("Cell not exists in cell")
        }
        
        cell.moviesVM = searchVM.getMoviesBySection(for: indexPath)
        cell.cellTapped = {[weak self] movie in
            guard let self = self else {return}
            navToDetails(for: movie)
        }
        return cell
    }
}
// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    // MARK: - Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return searchVM.heightForHeader
    }
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: headerId)
                as? SearchHeaderTableViewCell
        else {
            fatalError("Cell not exists in cell")
        }
        cell.title = searchVM.getTitleOfHeader(for: section)
        return cell
    }
}

