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
    
    func configure(with standartCell: UITableViewCell, TableSection: TableSections) {
        guard let label = standartCell.textLabel else {return}
        label.numberOfLines = 0
        
        guard let cityName = detailData.location?.cityName else {return}
        guard let townName = detailData.location?.townName else {return}
        guard let id = detailData.id else {return}
        guard let text = detailData.text else {return}
        
        switch TableSection {
        case .ModelName:
            label.text = detailData.modelName
        case .Price:
            label.text = FormatterManager.shared.numberFormatter(price: detailData.price)
            label.textColor = .systemRed
            label.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        case .Address:
            label.text = "\(cityName), \(townName)"
        case .AdvertNum:
            label.text = "\(id)"
        case .AdvertDate:
            label.text = detailData.dateFormatted
        ///case .Properties is configurated down below with DetailTableViewCell
        case .Explanation:
            label.attributedText = text.html2String
        case .Name:
            label.text = detailData.userInfo?.nameSurname
        case .Phone:
            label.text = detailData.userInfo?.phoneFormatted
        default:
            break
        }
    }
}

extension DetailViewModel {
    func configure(with detailCell: DetailTableViewCell, TableSection: TableSections, TablePropertiesRows: PropertiesRows) {
        let nameLabel = detailCell.propertiesLabel
        let valueLabel = detailCell.valueLabel
        
        guard let properties = detailData.properties else {return}
        
        if TableSection == .Properties {
            switch TablePropertiesRows {
            case .Kilometer:
                nameLabel?.text = "Kilometre"
                let value = properties.filter({$0.name == "km"})
                valueLabel?.text = FormatterManager.shared.kmFormatter(km: value.first?.value)
            case .Color:
                nameLabel?.text = "Rengi"
                let value = properties.filter({$0.name == "color"})
                valueLabel?.text = value.first?.value
            case .ModelYear:
                nameLabel?.text = "Model Yılı"
                let value = properties.filter({$0.name == "year"})
                valueLabel?.text = value.first?.value
            case .GearType:
                nameLabel?.text = "Vites Türü"
                let value = properties.filter({$0.name == "gear"})
                valueLabel?.text = value.first?.value
            case .FuelType:
                nameLabel?.text = "Yakıt Türü"
                let value = properties.filter({$0.name == "fuel"})
                valueLabel?.text = value.first?.value
            }
        }
    }
}
