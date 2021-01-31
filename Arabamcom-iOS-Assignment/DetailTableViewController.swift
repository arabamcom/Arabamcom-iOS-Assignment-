//
//  DetailTableViewController.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 30.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    //MARK: - Properties
    var id: Int = 0
    var vehicle: VehicleDetailModel? {
        didSet {
            tableView.reloadData()
        }
    }
    /// all 'i's are capital because section titles are capital and i's seems like 'ı'
    let sectionTitles = ["Model Adı", "Fİyat", "Adres", "İlan No", "İlan Tarİhİ", "Özellİkler", "Açıklama", "İsİm", "Telefon"]
    
    let label: UILabel = {
        let navLabel = UILabel()
        navLabel.backgroundColor = .clear
        navLabel.textColor = .black
        navLabel.textAlignment = .left
        navLabel.numberOfLines = 0
        navLabel.text = ""
        return navLabel
    }()
        
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        getVehicleDetail(id: id)
        
        navigationItem.titleView = label
        tableView.register(DetailTableViewCell.nib(), forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: 374, height: 50)
    }
    
    //MARK: - Network
    func getVehicleDetail(id: Int?) {
        guard let id = id else {return}
        VehicleClient.getVehicleDetail(id: id) { [weak self] (data, error) in
            print("Error with gettin vehicle detail: \(String(describing: error?.localizedDescription))")
            guard let self = self else {return}
            guard let vehicleDetail = data else {return}
            
            DispatchQueue.main.async {
                self.vehicle = vehicleDetail
                self.label.text = vehicleDetail.title
                self.configureTableHeaderView(vehicle: vehicleDetail)
            }
            
        }
    }
    
    //MARK: - Helper Methods
    private func configureTableHeaderView(vehicle: VehicleDetailModel) {
        if let tableHeaderView = CustomTableHeaderView.loadNib(owner: self) as? CustomTableHeaderView {
            tableView.tableHeaderView = tableHeaderView
            tableHeaderView.configureTableHeaderView()
            let detailViewModel = DetailViewModel(detailData: vehicle)
            detailViewModel.configure(with: tableHeaderView)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 9
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let properties = vehicle?.properties?.count else {return 0}
        switch section {
        case 0,1,2,3,4,6,7,8:
            return 1
        case 5:
            return properties
        default:
            break
        }
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0,1,2,3,4,6,7,8:
            let cell = UITableViewCell()
            if let vehicle = vehicle {
                let detailViewModel = DetailViewModel(detailData: vehicle)
                detailViewModel.configure(with: cell, indexPath: indexPath)
            }
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
            if let vehicle = vehicle {
                let detailViewModel = DetailViewModel(detailData: vehicle)
                detailViewModel.configure(with: cell, indexPath: indexPath)
            }
            cell.selectionStyle = .none
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
}
