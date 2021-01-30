//
//  ServiceClient.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 28.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import Alamofire

class ServiceClient {
    static func makeRequest<T: Codable>(route:URLRequestConvertible, codableType: T.Type, completion: @escaping (_ response: T?, _ error: Error?) -> Void){
        AF.request(route).validate().responseDecodable(of: T.self) { (response) in
            //TODO: remove before flight
            if let request = response.request,
               let url = request.url {
                print("URL: \(url.absoluteString)")
            }
            completion(response.value, response.error)
        }
    }
}
