//
//  CollectionViewModel.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 31.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CollectionViewModel {
    var vehicle: VehicleDetailModel
    var imagesWithResolution: [String] = []
    
    
    init(vehicle: VehicleDetailModel) {
        self.vehicle = vehicle
    }
    
    var vehicleImagesResourceURL: [String] {
        if let imageURLs = vehicle.photos {
            for image in imageURLs.indices {
                imagesWithResolution.append(imageURLs[image].replacingOccurrences(of: "{0}", with: "800x600"))
            }
        }
        return imagesWithResolution
    }
    
    var imageCount: Int {
        guard let count = vehicle.photos?.count else {return 0}
        return count
    }

    
    func configureCollectionCell(cell: CollectionViewCell, indexPath: IndexPath) {

        guard let url = URL(string: vehicleImagesResourceURL[indexPath.row]) else {return}
        let resource = ImageResource(downloadURL: url)
        cell.imageView.kf.setImage(with: resource)
        
        cell.imageCountLabel.text = "\(indexPath.row + 1) / \(imageCount)"
        
    }
    
    
    
}
