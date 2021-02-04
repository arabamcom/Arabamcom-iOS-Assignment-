//
//  VehicleRouter.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 28.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import Alamofire

enum VehicleRouter: URLRequestConvertible {

    //MARK: - URL
    static let baseURL = NetworkConstants.baseURL
    
    case getListVehicles(sort: Int? = 0,
                        sortDirection: Int? = 0,
                        minDate: String? = nil,
                        maxDate: String? = nil,
                        minYear: Int? = nil,
                        maxYear: Int? = nil,
                        skip: Int? = nil,
                        take: Int? = 10)
   
    
    case getVehicleDetail(id: Int?)
    
    //MARK: - Method
    var method: HTTPMethod{
        switch self {
        case .getListVehicles, .getVehicleDetail:
            return .get
        }
    }
    
    //MARK: - Path
    var path: String {
        switch self {
        case .getListVehicles:
            return "listing"
        case .getVehicleDetail:
            return "detail"
        }
    }
    
    //MARK: - Parameters
    var parameters: [String: Any] {
        switch self {
        case .getListVehicles(sort: let sort,
                           sortDirection: let sortDirection,
                           minDate: let minDate,
                           maxDate: let maxDate,
                           minYear: let minYear,
                           maxYear: let maxYear,
                           skip: let skip,
                           take: let take):
            
            var tmpParameters: [String: Any] = ["sort": sort as Any, "sortDirection": sortDirection as Any, "take": take as Any]
            if let skip = skip {
                tmpParameters["skip"] = skip
            }
            if let minDate = minDate {
                tmpParameters["minDate"] = minDate
            }
            if let maxDate = maxDate {
                tmpParameters["maxDate"] = maxDate
            }
            if let minYear = minYear {
                tmpParameters["minYear"] = minYear
            }
            if let maxYear = maxYear {
                tmpParameters["maxYear"] = maxYear
            }
            return tmpParameters
            
        case .getVehicleDetail(id: let id):
            return ["id": id as Any]
        
        }
    }
    
    //MARK: - URLRequest
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        request.timeoutInterval = 20
        return try URLEncoding.default.encode(request, with: parameters)
       }
   
}

