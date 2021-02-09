//
//  StringProtocol+Extensions.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 31.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: NSAttributedString {
        (html2AttributedString ?? NSAttributedString(string: "")) as NSAttributedString
    }
}
