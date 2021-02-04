//
//  UIBarButtonItem+Extensions.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 30.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    public static func setDoneBarButtonItem(target: Any?, action: Selector) -> UIToolbar {
        let bar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Tamam", style: .plain, target: target, action: action)
        doneBarButton.tintColor = .systemRed
        bar.sizeToFit()
        
        bar.items = [flexibleSpace, doneBarButton]
        return bar
    }
    
   
}
