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
   // func filteredResults(sort: Int, sortDirection: Int, minDate:String?, maxDate: String?, minYear: Int?, maxYear: Int?, skip: Int?, take: Int)
}

class ContentViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sortTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sortDirectionButton: UIButton!
    @IBOutlet weak var minYearTextField: UITextField!
    @IBOutlet weak var maxYearTextField: UITextField!
    @IBOutlet weak var changedButton: UIButton!
    @IBOutlet weak var selectDateTextField: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    
    
    //MARK: - Properties
    weak var delegate: ContentViewControllerDelegate?
    var sortDirection = true
    var selectedSegmentIndex = 0
    var minYear = ""
    var maxYear = ""
    var isChanged = true
    let dateSelections = ["Tarih Seç","Son 1 Gün", "Son 2 Gün", "Son 3 Gün", "Son 7 Gün", "Son 30 Gün"]
    var selectedDateFilter: String = ""
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.textFieldLeftSideSpace(textField: minYearTextField)
        UIView.textFieldLeftSideSpace(textField: maxYearTextField)
        UIView.textFieldLeftSideSpace(textField: selectDateTextField)
        UIView.setCornerRadius(viewElement: changedButton, cornerRadius: 5)
        UIView.setCornerRadius(viewElement: sortDirectionButton, cornerRadius: 10)
        UIView.setCornerRadius(viewElement: filterButton, cornerRadius: 10)
        
        sortDirectionButton.addTarget(self, action: #selector(didTappedSortDirection), for: .touchUpInside)
        sortTypeSegmentedControl.addTarget(self, action: #selector(didChangeSegment(sender:)), for: .valueChanged)
        changedButton.addTarget(self, action: #selector(didTappedChangeButton), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(didTappedFilterButton), for: .touchUpInside)
        
        minYearTextField.delegate = self
        maxYearTextField.delegate = self
        
        configureToolBar()
        createPickerView()
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
    
    @objc private func didTappedFilterButton(){
//        guard let maximumYear = maxYearTextField.text else {return}
//        guard let minimumYear = minYearTextField.text else {return}
//        
//        delegate?.filteredResults(sort: 0, sortDirection: 0, minDate: Date.getMinDate(), maxDate: selectedDateFilter, minYear: Int(minimumYear), maxYear: Int(maximumYear), skip: nil, take: 10)
    }
    

    private func configureToolBar(){

        maxYearTextField.inputAccessoryView = UIBarButtonItem.setDoneBarButtonItem(target: self, action: #selector(doneBarButtonTapped))
        minYearTextField.inputAccessoryView = UIBarButtonItem.setDoneBarButtonItem(target: self, action: #selector(doneBarButtonTapped))
    }
    
    @objc private func doneBarButtonTapped(){
        maxYearTextField.resignFirstResponder()
        minYearTextField.resignFirstResponder()
        selectDateTextField.resignFirstResponder()
    }
    
    //MARK: - Create PickerView
    private func createPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        selectDateTextField.inputView = pickerView
        
        selectDateTextField.inputAccessoryView = UIBarButtonItem.setDoneBarButtonItem(target: self, action: #selector(doneBarButtonTapped))
        pickerView.backgroundColor = UIColor.init(displayP3Red: 255, green: 255, blue: 255, alpha: 1)
        
    }
}

//MARK: - UITextfield Delegate
extension ContentViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 4
    }
}

//MARK: - UIPickerView Delegate & DataSource

extension ContentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateSelections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectDateTextField.text = dateSelections[row]
        switch row {
        case 0:
            selectDateTextField.text = ""
        case 1:
            selectedDateFilter = Date.getMaxDate(dateSelection: .lastDay)
        case 2:
            selectedDateFilter = Date.getMaxDate(dateSelection: .lastTwoDays)
        case 3:
            selectedDateFilter = Date.getMaxDate(dateSelection: .lastThreeDays)
        case 4:
            selectedDateFilter = Date.getMaxDate(dateSelection: .lastWeek)
        case 5:
             selectedDateFilter = Date.getMaxDate(dateSelection: .lastMonth)
        
        default:
            break
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.text = dateSelections[row]
        return label
    }
}
