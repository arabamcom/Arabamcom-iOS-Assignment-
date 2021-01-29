//
//  FilterViewController.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 29.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var sortType: UISegmentedControl!
    @IBOutlet weak var sortDirectionButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       configureNavigationBar()
        
        
        
    }
    
    //MARK: - Helper Methods
    func configureNavigationBar(){
         navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Uygula", style: .done, target: self, action: #selector(didTappedUygulaBarButton))
    }

    @objc func didTappedUygulaBarButton(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Fiyat")
        case 1:
            print("Gün")
        case 2:
            print("Yıl")
        default:
            print("")
        }
    }
}
