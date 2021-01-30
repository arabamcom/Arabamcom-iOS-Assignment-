//
//  ContentViewController.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 29.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

protocol ContentViewControllerDelegate: class {
    func sortChanged(sortDirection: Int, sortType: Int)
    
}

class ContentViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sortTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sortDirectionButton: UIButton!
    @IBOutlet weak var minYearTextField: UITextField!
    @IBOutlet weak var maxYearTextField: UITextField!
    @IBOutlet weak var changedButton: UIButton!
    
    //MARK: - Properties
    weak var delegate: ContentViewControllerDelegate?
    var sortDirection = true
    var selectedSegmentIndex = 0
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.textFieldLeftSideSpace(textField: minYearTextField)
        UIView.textFieldLeftSideSpace(textField: maxYearTextField)
        UIView.setCornerRadius(viewElement: changedButton, cornerRadius: 5)
        UIView.setCornerRadius(viewElement: sortDirectionButton, cornerRadius: 10)
        
        sortDirectionButton.addTarget(self, action: #selector(didTappedSortDirection), for: .touchUpInside)
        sortTypeSegmentedControl.addTarget(self, action: #selector(didChangeSegment(sender:)), for: .valueChanged)
    }

    //MARK: - Helper Methods
    @objc private func didTappedSortDirection(){
        sortDirectionButton.isHighlighted = true

        if sortDirection == true {
            delegate?.sortChanged(sortDirection: 1, sortType: selectedSegmentIndex)
            sortDirection.toggle()
        } else {
            delegate?.sortChanged(sortDirection: 0, sortType: selectedSegmentIndex)
            sortDirection.toggle()
        }
        
       
    }
   
    
    @objc private func didChangeSegment(sender: UISegmentedControl){
                
        if sortDirection == false {
            delegate?.sortChanged(sortDirection: 0, sortType: sender.selectedSegmentIndex)
            selectedSegmentIndex = sender.selectedSegmentIndex
            sortDirection.toggle()
        } else if sortDirection == true {
            delegate?.sortChanged(sortDirection: 1, sortType: sender.selectedSegmentIndex)
            selectedSegmentIndex = sender.selectedSegmentIndex
            sortDirection.toggle()
        }
        
       
    }
    
    
    
}
