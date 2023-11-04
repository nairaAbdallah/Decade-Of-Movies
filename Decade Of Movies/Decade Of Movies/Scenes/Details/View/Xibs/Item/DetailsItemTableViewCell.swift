//
//  DetailsItemTableViewCell.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit

class DetailsItemTableViewCell: UITableViewCell {
    // MARK: - Properties
    
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
