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
                           take: let take):
            
            var tmpParameters: [String: Any] = ["sort": sort, "sortDirection": sortDirection, "take": take]
            if minDate != nil {
                tmpParameters["minDate"] = minDate!
            }
            if maxDate != nil {
                tmpParameters["maxDate"] = maxDate!
            }
            if minYear != nil {
                tmpParameters["minYear"] = minYear!
            }
            if maxYear != nil {
                tmpParameters["maxYear"] = maxYear!
            }
            return tmpParameters
            
        case .getVehicleDetail(id: let id):
            return ["id": id]
        
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

