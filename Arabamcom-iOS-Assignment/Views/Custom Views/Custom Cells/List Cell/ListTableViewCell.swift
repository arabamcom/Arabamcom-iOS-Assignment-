//
//  ListTableViewCell.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 28.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    //MARK: - Outlets
   
    @IBOutlet weak var vehicleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
        
    //MARK: Properties

    public static let identifier = "ListTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Helper Methods
    static func nib() -> UINib {
        return UINib(nibName: "ListTableViewCell", bundle: nil)
    }
}
