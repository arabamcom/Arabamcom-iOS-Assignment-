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
    
    var sections: [TableSections] = [.ModelName, .Price, .Address, .AdvertNum, .AdvertDate, .Properties, .Explanation, .Name, .Phone]
    var propertieRows: [PropertiesRows] = [.Kilometer, .Color, .ModelYear, .GearType, .FuelType, .Kilometer]
    
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
        configureTableView()
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
                self.configureTableHeaderCollectionView(vehicle: vehicleDetail)
            }
            
        }
    }
    
    //MARK: - Helper Methods
    private func configureTableHeaderCollectionView(vehicle: VehicleDetailModel) {
        if let tableHeaderView = ImageTableHeaderCollectionView.loadNib(owner: self) as? ImageTableHeaderCollectionView {
            tableView.tableHeaderView = tableHeaderView
            tableHeaderView.collectionView.delegate = self
            tableHeaderView.collectionView.dataSource = self
            tableHeaderView.collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
         }
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        sections.forEach { (section) in
            section.register(tableView: tableView)
        }
    }
    
    //MARK: - Navigation
    private func goFullscreen(){
        let fullscreenVC = FullScreenViewController()
        fullscreenVC.vehicle = vehicle
        fullscreenVC.modalPresentationStyle = .fullScreen
        self.present(fullscreenVC, animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
     
        return sections[section].numberOfItems(propertiesRows: propertieRows)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch sections[indexPath.section] {
        case .ModelName,.Price, .Address, .AdvertNum, .AdvertDate, .Explanation, .Name, .Phone:
            let cell = UITableViewCell()
            if let vehicle = vehicle {
                let detailViewModel = DetailViewModel(detailData: vehicle)

                detailViewModel.configure(with: cell, TableSection: sections[indexPath.section])
            }
            cell.selectionStyle = .none
            return cell
        case .Properties:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
            if let vehicle = vehicle {
                let detailViewModel = DetailViewModel(detailData: vehicle)

                detailViewModel.configure(with: cell, TableSection: sections[indexPath.section], TablePropertiesRows: propertieRows[indexPath.row])
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionTitle()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        if sections[indexPath.section] == .Phone {
            ///Swipe to call
            let callAction = UIContextualAction(style: .normal, title: nil) { (_, _, completion) in
                guard let phone = self.vehicle?.userInfo?.phone else {return}
                if let url = NSURL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.open(url as URL)
                }
                    completion(true)
                }
                
                if #available(iOS 13.0, *) {
                    callAction.image = UIImage(systemName: "phone.fill")
                } else {
                    callAction.image = UIImage(named: "phone.fill")
                }
                callAction.backgroundColor = .systemGreen
                let config = UISwipeActionsConfiguration(actions: [callAction])
                config.performsFirstActionWithFullSwipe = true
                return config
            }
        return UISwipeActionsConfiguration()
        }
}

//MARK: - Collection View Delegate & Datasource
extension DetailTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehicle?.photos?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        guard let vehicle = vehicle else {return UICollectionViewCell()}
        let collectionViewModel = CollectionViewModel(vehicle: vehicle)
        collectionViewModel.configureCollectionCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 364, height: 283)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goFullscreen()
    }
    
}
