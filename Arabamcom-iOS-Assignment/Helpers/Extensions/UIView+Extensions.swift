//
//  UIView+Extensions.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 30.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    //MARK: - TextField
    public static func textFieldLeftSideSpace(textField: UITextField){
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
    }
    
    //MARK: Corner Radius
    public static func setCornerRadius(viewElement: UIView, cornerRadius: CGFloat) {
        viewElement.layer.cornerRadius = cornerRadius
        viewElement.layer.masksToBounds = true
    }
}
