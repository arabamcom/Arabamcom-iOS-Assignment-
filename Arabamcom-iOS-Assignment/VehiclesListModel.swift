//
//  VehiclesListModel.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 28.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation

typealias VehiclesListModelArray = [VehiclesListModel]
// MARK: - VehiclesListModelElement
struct VehiclesListModel: Codable {
    var id: Int?
    var title: String?
    var location: Location?
    var category: Category?
    var modelName: String?
    var price: Int?
    var priceFormatted, date, dateFormatted, photo: String?
    var properties: [Property]?
}

// MARK: - Category
struct Category: Codable {
    var id: Int?
    var name: String?
}

// MARK: - Location
struct Location: Codable {
    var cityName, townName: String?
}

// MARK: - Property
struct Property: Codable {
    var name: String?
    var value: String?
}


