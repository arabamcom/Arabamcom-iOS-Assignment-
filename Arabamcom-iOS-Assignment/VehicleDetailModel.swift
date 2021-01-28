//
//  VehicleDetailModel.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 28.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation

// MARK: - VehicleDetailModel
struct VehicleDetailModel: Codable {
    var id: Int?
    var title: String?
    var location: Location?
    var category: Category?
    var modelName: String?
    var price: Int?
    var priceFormatted, date, dateFormatted: String?
    var photos: [String]?
    var properties: [Property]?
    var text: String?
    var userInfo: UserInfo?
}

// MARK: - UserInfo
struct UserInfo: Codable {
    var id: Int?
    var nameSurname, phone, phoneFormatted: String?
}
