//
//  MyFloatingPanelLayout.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 29.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import FloatingPanel

public class MyFloatingPanelLayout: FloatingPanelLayout {
    public var position: FloatingPanelPosition{
        .bottom
    }
    public var initialState: FloatingPanelState {
        .half
    }
    
    public var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 32.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 185.0, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 14.0, edge: .bottom, referenceGuide: .safeArea)
            ]
    }
    public func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}
