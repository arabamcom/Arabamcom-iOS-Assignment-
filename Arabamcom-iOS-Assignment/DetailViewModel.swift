//
//  DetailViewModel.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 31.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class DetailViewModel {
    var detailData: VehicleDetailModel
    
    init(detailData: VehicleDetailModel) {
        self.detailData = detailData
    }
    
    func configure(with standartCell: UITableViewCell, indexPath: IndexPath) {
        guard let label = standartCell.textLabel else {return}
        label.numberOfLines = 0
        
        switch indexPath.section {
        case 0:
            label.text = detailData.modelName
        case 1:
            label.text = FormatterManager.shared.numberFormatter(price: detailData.price)
        case 2:
            label.text = "\(String(describing: detailData.location?.cityName)), \(String(describing: detailData.location?.townName))"
        case 3:
            label.text = "\(String(describing: detailData.id))"
        case 4:
            label.text = detailData.dateFormatted
        case 6:
            label.text = detailData.text
            ///case 5 is for properties
        case 7:
            label.text = detailData.userInfo?.nameSurname
        case 8:
            label.text = detailData.userInfo?.phoneFormatted
        default:
            break
        }
    }
}

extension DetailViewModel {
    func configure(with view: CustomTableHeaderView) {
        guard let imageURL = detailData.photos?.first else {return}
        let imageURLWithResolution = imageURL.replacingOccurrences(of: "{0}", with: "800x600")
        guard let url = URL(string: imageURLWithResolution) else {return}
        let resource = ImageResource(downloadURL: url)
        view.vehicleImageView.kf.setImage(with: resource)
    }
}

extension DetailViewModel {
    func configure(with detailCell: DetailTableViewCell, indexPath: IndexPath) {
        let nameLabel = detailCell.propertiesLabel
        let valueLabel = detailCell.valueLabel
        
        guard let properties = detailData.properties else {return}
        
        for propertie in properties.indices {
            if indexPath.row == propertie {
                nameLabel?.text = "\(String(describing: properties[indexPath.row].name))"
                valueLabel?.text = "\(String(describing: properties[indexPath.row].value))"
            }
        }
    }
}
