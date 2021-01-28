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
    var isPagination = false
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ListTableViewCell.nib(), forCellReuseIdentifier: ListTableViewCell.identifier)
        configureNavigationBar()
        
        getLists(pagination: true)
    }
    
    //MARK: - Helper Methods
    private func getLists(pagination: Bool = false){
        
        var take = 0
        if pagination {
            isPagination = true
            take = 10
            VehicleClient.getListVehicle(sort: 0, sortDirection: 0, skip: pagination ? allVehicles.count : nil, take: take) {[weak self] (data, error) in
            print("Getting List Error: \(String(describing: error?.localizedDescription))")
            guard let self = self else {return}
                
                defer {
                    if pagination {
                        self.isPagination = false
                    }
                }
                
            guard let newData = data else {
                print("Data error: \(String(describing: error?.localizedDescription))")
                return
            }
          
            guard !self.isPagination || !self.allVehicles.contains(where: {$0.id == newData.first?.id}) else {return}
            self.allVehicles.append(contentsOf: newData)
            
          
          }
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

//MARK: - Pagination

extension ListTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 50 - scrollView.frame.size.height) {

            guard !isPagination && !allVehicles.isEmpty else {return}
            isPagination = true
           getLists(pagination: true)
               
        }
    }
}
