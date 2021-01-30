//
//  DetailTableViewCell.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 30.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var propertiesLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    //MARK: - Properties
    public static let identifier = "DetailTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Helper Methods
    public static func nib() -> UINib {
        return UINib(nibName: "DetailTableViewCell", bundle: nil)
    }
    
}
