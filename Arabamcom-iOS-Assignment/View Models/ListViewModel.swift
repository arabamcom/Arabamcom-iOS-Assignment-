//
//  ListViewModel.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 28.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ListViewModel {
    var vehicles: VehiclesListModel
    
    init(vehicles: VehiclesListModel) {
        self.vehicles = vehicles
    }
    
    var vehicleImageResourceURL: String {
        guard let imageURL = vehicles.photo else {return ""}
        let imageURLWithResolution = ResolutionManager.shared.convertUrlWithResolution(url: imageURL, resolution: .small)
        return imageURLWithResolution
    }
    
    var title: String {
        guard let title = vehicles.title else {return ""}
        return title
    }
    
    var locationInfo: String {
        guard let city = vehicles.location?.cityName else {return " "}
        guard let town = vehicles.location?.townName else {return ""}
        return "\(city), \(town)"
    }
    
    var price: String {
        guard let vehiclePrice = vehicles.price else {return ""}
        return FormatterManager.shared.numberFormatter(price: vehiclePrice)
    }
}

extension ListViewModel {
    func configureListCell(with cell: ListTableViewCell){
        cell.titleLabel.text = title
        cell.locationLabel.text = locationInfo
        cell.priceLabel.text = price
        guard let url = URL(string: vehicleImageResourceURL) else {return}
        let resource = ImageResource(downloadURL: url)
        cell.vehicleImageView.kf.setImage(with: resource, options: [.memoryCacheExpiration(.seconds(900))])
    }
}
