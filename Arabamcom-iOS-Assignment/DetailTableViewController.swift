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
    /// all 'i's are capital because section titles are capital and İ's seems like 'I'
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
        tableView.estimatedRowHeight = 60
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        if indexPath.section == 8 {
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
