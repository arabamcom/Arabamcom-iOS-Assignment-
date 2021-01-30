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
    var minYear = ""
    var maxYear = ""
    var isChanged = true
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.textFieldLeftSideSpace(textField: minYearTextField)
        UIView.textFieldLeftSideSpace(textField: maxYearTextField)
        UIView.setCornerRadius(viewElement: changedButton, cornerRadius: 5)
        UIView.setCornerRadius(viewElement: sortDirectionButton, cornerRadius: 10)
        
        sortDirectionButton.addTarget(self, action: #selector(didTappedSortDirection), for: .touchUpInside)
        sortTypeSegmentedControl.addTarget(self, action: #selector(didChangeSegment(sender:)), for: .valueChanged)
        changedButton.addTarget(self, action: #selector(didTappedChangeButton), for: .touchUpInside)
        
        minYearTextField.delegate = self
        maxYearTextField.delegate = self
        
       configureToolBar()
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
    
    @objc private func didTappedChangeButton(){
        minYear = minYearTextField.text ?? ""
        maxYear = maxYearTextField.text ?? ""
        
        if isChanged == false {
            maxYearTextField.text = minYear
            minYearTextField.text = maxYear
            maxYear = maxYearTextField.text ?? ""
            minYear = minYearTextField.text ?? ""
            
            isChanged.toggle()
        } else {
            minYearTextField.text = maxYear
            maxYearTextField.text = minYear
            maxYear = maxYearTextField.text ?? ""
            minYear = minYearTextField.text ?? ""
            isChanged.toggle()
        }
        
    }
    
    //MARK: - Configure ToolBar
    private func configureToolBar(){
        let bar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(doneBarButtonTapped))
        
        bar.items = [flexibleSpace ,doneBarButton]
        bar.sizeToFit()
        maxYearTextField.inputAccessoryView = bar
        minYearTextField.inputAccessoryView = bar
    }
    
    @objc private func doneBarButtonTapped(){
        maxYearTextField.resignFirstResponder()
        minYearTextField.resignFirstResponder()
    }
}

//MARK: - UITextfield Delegate
extension ContentViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 4
    }
}
