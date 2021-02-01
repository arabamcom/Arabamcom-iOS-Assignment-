//
//  ImageTableHeaderCollectionView.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 31.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

class ImageTableHeaderCollectionView: UIView {

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - Helper Methods
    
    static func loadNib(owner: UIViewController) -> Any? {
        Bundle.main.loadNibNamed("ImageTableHeaderCollectionView", owner: owner, options: nil)?.first
    }
    

}
