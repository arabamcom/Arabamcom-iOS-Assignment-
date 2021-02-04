//
//  ListViewController.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 29.01.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit
import FloatingPanel

class ListViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var allVehicles: [VehiclesListModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var isPagination = false
    let fpc = FloatingPanelController()
    var sortType = 0
    var sortDirection = 0
    var minYear: Int?
    var maxYear: Int?
    var minDate: String?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        getLists(pagination: true)
        configureContentVC()
    }
    
    //MARK: - Network
    private func getLists(pagination: Bool = false){
        
        VehicleClient.getListVehicle(sort: sortType,
                                     sortDirection: sortDirection,
                                     skip: pagination ? allVehicles.count : nil,
                                     take: 10,
                                     minDate: minDate != nil ? minDate : nil,
                                    minYear: self.minYear, maxYear: self.maxYear) { [weak self] (data, error) in
                print("Getting list error: \(String(describing: error?.localizedDescription))")
                guard let self = self else {return}
                
                defer {
                    if pagination {
                        self.isPagination = false
                    }
                }
                
                guard let newData = data else {
                    print("New Data error \(String(describing: error?.localizedDescription))")
                    return
                }
                                        
                if !self.isPagination {
                   self.allVehicles = newData
                }
                
                guard !self.isPagination || !self.allVehicles.contains(where: {$0.id == newData.first?.id}) else {return}
                self.allVehicles.append(contentsOf: newData)
                                        
                if newData.isEmpty {
                    self.fireAlertMessage(message: "Belirlenen kriterlere uygun ilan bulunamadı.")
                }
            }
        
    }

    //MARK: - Helper Methods
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ListTableViewCell.nib(), forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "İlanlar"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func createSpinnerFooter() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func fireAlertMessage(message: String) {
        let alertController = UIAlertController(title: "Dikkat", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .cancel) { (_) in
            self.fpc.move(to: .full, animated: true)
        }
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Floating Panel
    private func configureContentVC(){
        let contentVC = ContentViewController()
        contentVC.delegate = self
        fpc.set(contentViewController: contentVC)
        fpc.contentMode = .fitToBounds
        fpc.layout = MyFloatingPanelLayout()
        fpc.addPanel(toParent: self)
        fpc.move(to: .tip, animated: true)
        fpc.setApperance()
        fpc.track(scrollView: contentVC.scrollView)
        fpc.delegate = self
    }
    
    //MARK: - Navigation
    func goDetaiVC(with id: Int){
        let detailTableVC = DetailTableViewController()
        detailTableVC.id = id
        self.navigationController?.pushViewController(detailTableVC, animated: true)
    }
    
}

//MARK: - UITable View Delegate & Data Source
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allVehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let listViewModel = ListViewModel(vehicles: allVehicles[indexPath.row])
        listViewModel.configureListCell(with: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedVehicleID = allVehicles[indexPath.row].id else {return}
        goDetaiVC(with: selectedVehicleID)
    }
}

//MARK: - Pagination
extension ListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ///activate pagination last 100 cgfloat of screen
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height){
            
            guard !isPagination && !allVehicles.isEmpty else {return}
            isPagination = true
            self.tableView.tableFooterView = self.createSpinnerFooter()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.getLists(pagination: true)
                self.tableView.tableFooterView = nil
            }
        }
    }
}

//MARK: - FloatingPanelController Delegate

extension ListViewController: FloatingPanelControllerDelegate {
    
    func floatingPanelWillEndDragging(_ fpc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
        if targetState.pointee != .tip {
            fpc.contentMode = .static
        }
    }
    
    func floatingPanelDidEndAttracting(_ fpc: FloatingPanelController) {
        fpc.contentMode = .fitToBounds
    }
}

//MARK: - ContentVC Delegate
extension ListViewController: ContentViewControllerDelegate {
    
    func sortChanged(sortType: Int, sortDirection: Int) {
        allVehicles.removeAll()
        self.sortType = sortType
        self.sortDirection = sortDirection
        getLists()
        fpc.move(to: .half, animated: true)
    }
    
    func filterChanged(sortType: Int, sortDirection: Int, minYear: Int?, maxyear: Int?, minDate: String?) {
        allVehicles.removeAll()
        self.sortType = sortType
        self.sortDirection = sortDirection
        self.maxYear = maxyear
        self.minYear = minYear
        self.minDate = minDate
        getLists()
        fpc.move(to: .tip, animated: true)
    }
    

}
