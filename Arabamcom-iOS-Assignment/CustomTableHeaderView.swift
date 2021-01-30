//
//  CustomTableHeaderView.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 30.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

class CustomTableHeaderView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var vehicleImageView: UIImageView!
    
    //MARK: - Helper Methods
    static func loadNib(owner: UIViewController) -> Any? {
        Bundle.main.loadNibNamed("CustomTableHeaderView", owner: owner, options: nil)?.first
    }
    
    func configureTableHeaderView(){
        self.frame.size.height = 293
        self.frame.size.width = 374
        
        vehicleImageView.layer.cornerRadius = 10.0
    }
}
