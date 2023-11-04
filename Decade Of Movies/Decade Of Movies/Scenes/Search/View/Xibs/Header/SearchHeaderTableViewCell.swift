//
//  SearchHeaderTableViewCell.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

class SearchHeaderTableViewCell: UITableViewCell {
    // MARK: - Properties
    var title: String = "" {
        didSet {
            headerTitle.text = title
        }
    }
    // MARK: - IBOutlet
    @IBOutlet weak var headerTitle: UILabel!
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}
