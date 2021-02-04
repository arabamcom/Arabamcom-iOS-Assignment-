//
//  FullscreenCollectionViewCell.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 1.02.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

class FullscreenCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var fullscreenImageView: UIImageView!
    @IBOutlet weak var imageCountLabel: UILabel!
    
    
    //MARK: - Properties
    static let identifier = "FullscreenCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    //MARK: - Helper Methods
    
    static func nib() -> UINib {
        return UINib(nibName: "FullscreenCollectionViewCell", bundle: nil)
    }

}
