//
//  ListTableViewController.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 28.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    //MARK: - Properties
    var allVehicles: [VehiclesListModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ListTableViewCell.nib(), forCellReuseIdentifier: ListTableViewCell.identifier)
        configureNavigationBar()
        
        getLists()
    }
    
    //MARK: - Helper Methods
    private func getLists(){
        VehicleClient.getListVehicle(sort: 0, sortDirection: 0, take: 10) {[weak self] (data, error) in
            print("Getting List Error: \(error?.localizedDescription)")
            guard let self = self else {return}
            
            guard let data = data else {
                print("Data error: \(error?.localizedDescription)")
                return
            }
            self.allVehicles = data
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return allVehicles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let listViewModel = ListViewModel(vehicles: allVehicles[indexPath.row])
        listViewModel.configureListCell(with: cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Helper Methods
    private func configureNavigationBar(){
        navigationItem.title = "List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
}
