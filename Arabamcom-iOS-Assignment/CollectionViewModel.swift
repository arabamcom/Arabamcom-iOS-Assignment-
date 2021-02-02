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
    var isInFullscreen = true
    
    init(vehicle: VehicleDetailModel) {
        self.vehicle = vehicle
    }
    
    var vehicleImagesResourceURL: [String] {
        if let imageURLs = vehicle.photos {
            for image in imageURLs.indices {
                ///Just for resolution adjustment when tapped the photo it will high resolution otherwise mid resolution.
                imagesWithResolution.append(isInFullscreen ? ResolutionManager.shared.convertUrlWithResolution(url: imageURLs[image], resolution: .middle) : ResolutionManager.shared.convertUrlWithResolution(url: imageURLs[image], resolution: .high))
            }
        }
        return imagesWithResolution
    }
    
    var imageCount: Int {
        guard let count = vehicle.photos?.count else {return 0}
        return count
    }

    //MARK: - Configure Detail Screen Photos
    func configureCollectionCell(cell: CollectionViewCell, indexPath: IndexPath) {
        guard let url = URL(string: vehicleImagesResourceURL[indexPath.row]) else {return}
        let resource = ImageResource(downloadURL: url)
        cell.imageView.kf.setImage(with: resource)
        
        cell.imageCountLabel.text = "\(indexPath.row + 1)/\(imageCount)"
        
    }
    
    //MARK: - Configure Fullscreen Photos
    func configureFullscreenCell(cell: FullscreenCollectionViewCell, indexPath: IndexPath){
        isInFullscreen.toggle()
        guard let url = URL(string: vehicleImagesResourceURL[indexPath.row]) else {return}
        let resource = ImageResource(downloadURL: url)
        cell.fullscreenImageView.kf.setImage(with: resource)
        cell.imageCountLabel.text = "\(indexPath.row + 1)/\(imageCount)"
        
    }
    
}
