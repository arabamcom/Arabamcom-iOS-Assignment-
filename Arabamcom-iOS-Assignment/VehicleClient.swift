//
//  VehicleClient.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 28.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import Alamofire

class VehicleClient: ServiceClient {
    public static func getListVehicle(sort: Int, sortDirection: Int, skip: Int?, take: Int, completion: @escaping (_ response: VehiclesListModelArray?, _ error: Error?) -> Void){
        makeRequest(route: VehicleRouter.getListVehicles(sort: sort, sortDirection: sortDirection, skip: skip, take: take), codableType: VehiclesListModelArray.self, completion: completion)
    }
}
