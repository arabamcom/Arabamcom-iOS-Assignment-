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
        
        guard let cityName = detailData.location?.cityName else {return}
        guard let townName = detailData.location?.townName else {return}
        guard let id = detailData.id else {return}
        guard let text = detailData.text else {return}
        
        switch indexPath.section {
        case 0:
            label.text = detailData.modelName
        case 1:
            label.text = FormatterManager.shared.numberFormatter(price: detailData.price)
            label.textColor = .systemRed
            label.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        case 2:
            label.text = "\(cityName), \(townName)"
        case 3:
            label.text = "\(id)"
        case 4:
            label.text = detailData.dateFormatted
        case 6:
            label.attributedText = text.html2String
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
    func configure(with detailCell: DetailTableViewCell, indexPath: IndexPath) {
        let nameLabel = detailCell.propertiesLabel
        let valueLabel = detailCell.valueLabel
        
        guard let properties = detailData.properties else {return}
        
        
        for propertie in properties.indices {
            if indexPath.row == propertie {
                let propertyName = properties[indexPath.row].name
                let propertyValue = properties[indexPath.row].value
                
                switch propertyName {
                case "km":
                    nameLabel?.text = propertyName?.replacingOccurrences(of: "km", with: "Kilometre")
                case "color":
                     nameLabel?.text = propertyName?.replacingOccurrences(of: "color", with: "Rengi")
                case "year":
                    nameLabel?.text = propertyName?.replacingOccurrences(of: "year", with: "Model Yılı")
                case "gear":
                    nameLabel?.text = propertyName?.replacingOccurrences(of: "gear", with: "Vites")
                case "fuel":
                    nameLabel?.text = propertyName?.replacingOccurrences(of: "fuel", with: "Yakıt")
                default:
                    break
                }
                
                if indexPath.row == 0 {
                    valueLabel?.text = "\(FormatterManager.shared.kmFormatter(km: properties[0].value))"
                } else {
                    valueLabel?.text = "\(propertyValue ?? "")"
                }
                
            }
        }
    }
}
