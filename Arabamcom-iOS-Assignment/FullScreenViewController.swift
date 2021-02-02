//
//  FullScreenViewController.swift
//  Arabamcom-iOS-Assignment
//
//  Created by Mehmet on 1.02.2021.
//  Copyright © 2021 Mehmet. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var fullscreenCollectionView: UICollectionView!
    
    //MARK: - Properties
    var vehicle: VehicleDetailModel?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        fullscreenCollectionView.delegate = self
        fullscreenCollectionView.dataSource = self
        fullscreenCollectionView.register(FullscreenCollectionViewCell.nib(), forCellWithReuseIdentifier: FullscreenCollectionViewCell.identifier)
        
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didPanDown))
        swipeDownRecognizer.direction = .down
        fullscreenCollectionView.addGestureRecognizer(swipeDownRecognizer)
       
    }
   
    //MARK: - Helper methods
 
    @objc func didPanDown(){
        self.dismiss(animated: true, completion: nil)
    }

}

//MARK: - CollectionView Delegate &  DataSource

extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehicle?.photos?.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FullscreenCollectionViewCell.identifier, for: indexPath) as! FullscreenCollectionViewCell
        guard let vehicle = vehicle else {return UICollectionViewCell()}
        let collectionViewModel = CollectionViewModel(vehicle: vehicle)
        collectionViewModel.configureFullscreenCell(cell: cell, indexPath: indexPath)
    
        return cell
    }
    
}
