//
//  CollectionViewCell.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 31.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Properties
    static let identifier = "CollectionViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame.size.width = 374
        self.frame.size.height = 293
    }
    
    //MARK: - Helper Methods
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }

}
