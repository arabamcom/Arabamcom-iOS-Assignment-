//
//  TableSection.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 12.02.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Table Sections
enum TableSections {
       case ModelName, Price, Address, AdvertNum, AdvertDate, Properties, Explanation, Name, Phone
       
    func numberOfItems(propertiesRows: [PropertiesRows]) -> Int {
        switch self {
        case .Properties:
            return propertiesRows.count
        default:
            return 1
        }
    }
       func sectionTitle() -> String {
           switch self {
           case .ModelName:
               return "MODEL ADI"
           case .Price:
               return "FİYAT"
           case .Address:
               return "ADRES"
           case .AdvertNum:
               return "İLAN NO"
           case .AdvertDate:
               return "İLAN TARİHİ"
           case .Properties:
               return "ÖZELLİKLER"
           case .Explanation:
               return "AÇIKLAMA"
           case .Name:
               return "İSİM"
           case .Phone:
               return "TELEFON"
           
           }
       }
       
       func register(tableView: UITableView) {
           switch self {
           case .Properties:
               tableView.register(DetailTableViewCell.nib(), forCellReuseIdentifier: DetailTableViewCell.identifier)
           default:
               break
           }
       }
   }
