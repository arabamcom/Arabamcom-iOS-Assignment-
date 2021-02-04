//
//  ContentViewController.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 29.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

protocol ContentViewControllerDelegate: class {
    func sortChanged(sortType: Int ,sortDirection: Int)
    func filterChanged(sortType: Int, sortDirection: Int, minYear: Int?, maxyear: Int?, minDate: String?)
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
    var minYear: Int?
    var maxYear: Int?
    let dateSelections = ["Tarih Seç",
                          "Son 1 Gün",
                          "Son 2 Gün",
                          "Son 3 Gün",
                          "Son 7 Gün",
                          "Son 30 Gün",
                          "Son 45 Gün",
                          "Son 60 Gün",
                          "Son 90 Gün"]
    var selectedDateFilter: String?
    var selectedDate = 0
    
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
    
    
    //MARK: - Actions
    @objc private func didTappedSortDirection(){
        
        sortDirection ? delegate?.sortChanged(sortType: selectedSegmentIndex, sortDirection: 1) : delegate?.sortChanged(sortType: selectedSegmentIndex, sortDirection: 0)
        
        sortDirection.toggle()
    }
   
    @objc private func didChangeSegment(sender: UISegmentedControl){

        sortDirection ? delegate?.sortChanged(sortType: sender.selectedSegmentIndex, sortDirection: 0) : delegate?.sortChanged(sortType: sender.selectedSegmentIndex, sortDirection: 1)
        self.selectedSegmentIndex = sender.selectedSegmentIndex

    }
    
    @objc private func didTappedChangeButton(){
        let tempMin = minYearTextField.text
        minYearTextField.text = maxYearTextField.text
        maxYearTextField.text = tempMin
    }
    
    @objc private func didTappedFilterButton(){

        if let minYearText = minYearTextField.text,
            !minYearText.isEmpty,
            let minYear = Int(minYearText) {
            self.minYear = minYear
        }
        
        if let maxYearText = maxYearTextField.text,
            !maxYearText.isEmpty,
            let maxYear = Int(maxYearText) {
            self.maxYear = maxYear
        }
        
        if sortDirection == false {
            self.delegate?.filterChanged(sortType: selectedSegmentIndex,
            sortDirection: 0,
            minYear: self.minYear,
            maxyear: self.maxYear,
            minDate: self.selectedDateFilter)
            sortDirection.toggle()
        } else if sortDirection == true {
            self.delegate?.filterChanged(sortType: selectedSegmentIndex,
            sortDirection: 1,
            minYear: self.minYear,
            maxyear: self.maxYear,
            minDate: self.selectedDateFilter)
            sortDirection.toggle()
        }
        
    }
    
    private func configureToolBar(){

        maxYearTextField.inputAccessoryView = UIBarButtonItem.setDoneBarButtonItem(target: self, action: #selector(doneBarButtonTapped))
        minYearTextField.inputAccessoryView = UIBarButtonItem.setDoneBarButtonItem(target: self, action: #selector(doneBarButtonTapped))
    }
    
    @objc private func doneBarButtonTapped(){
        if maxYearTextField.text == "" && minYearTextField.text == ""{
            self.maxYear = nil
            self.minYear = nil
        }
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
            selectedDateFilter = nil
        case 1:
            selectedDateFilter = Date.getMinDate(dateSelection: .lastDay)
        case 2:
            selectedDateFilter = Date.getMinDate(dateSelection: .lastTwoDays)
        case 3:
            selectedDateFilter = Date.getMinDate(dateSelection: .lastThreeDays)
        case 4:
            selectedDateFilter = Date.getMinDate(dateSelection: .lastWeek)
        case 5:
             selectedDateFilter = Date.getMinDate(dateSelection: .lastMonth)
        case 6:
            selectedDateFilter = Date.getMinDate(dateSelection: .last45days)
        case 7:
            selectedDateFilter = Date.getMinDate(dateSelection: .last60days)
        case 8:
            selectedDateFilter = Date.getMinDate(dateSelection: .last90days)
        
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
