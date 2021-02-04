//
//  FloatingPanel+Extensions.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 29.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import FloatingPanel

extension FloatingPanelController {
    func setApperance() {
        let apperance = SurfaceAppearance()
        apperance.cornerRadius = 10.0
        apperance.backgroundColor = .clear
        apperance.borderWidth = 2
        apperance.borderColor = .darkGray
        surfaceView.appearance = apperance
    }
}
