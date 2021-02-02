//
//  ResolutionManager.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 1.02.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation

class ResolutionManager {
    
    public static let shared = ResolutionManager()
    
    enum Resolution {
           case small, middle, high
           var selectedResolution: String {
               switch self {
               case .small:
                   return "120x90"
               case .middle:
                   return "800x600"
               case .high:
                   return "1920x1080"
               }
           }
       }
    
    func convertUrlWithResolution(url: String, resolution: Resolution) -> String {
        return url.replacingOccurrences(of: "{0}", with: resolution.selectedResolution)
    }
}
