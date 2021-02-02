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
    let fullScreenCell = FullscreenCollectionViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fullscreenCollectionView.delegate = self
        fullscreenCollectionView.dataSource = self
        fullscreenCollectionView.register(FullscreenCollectionViewCell.nib(), forCellWithReuseIdentifier: FullscreenCollectionViewCell.identifier)
        
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didPanDown))
        swipeDownRecognizer.direction = .down
        fullscreenCollectionView.addGestureRecognizer(swipeDownRecognizer)
        
//        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedDouble(recognizer:)))
//        doubleTapGesture.numberOfTapsRequired = 2
//        fullscreenCollectionView.addGestureRecognizer(doubleTapGesture)
    }
   
    //MARK: - Helper methods
 
    @objc func didPanDown(){
        self.dismiss(animated: true, completion: nil)
    }
    
//    @objc func didTappedDouble(recognizer: UITapGestureRecognizer){
//        if fullscreenCollectionView.zoomScale == 1 {
//            fullscreenCollectionView.zoom(to: zoomRectForScale(scale: fullscreenCollectionView.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
//        } else {
//            fullscreenCollectionView.setZoomScale(1, animated: true)
//        }
//    }
//
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return fullScreenCell.fullscreenImageView
//    }
//
//    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
//        var zoomRect = CGRect.zero
//        zoomRect.size.height = fullScreenCell.fullscreenImageView.frame.size.height / scale
//        zoomRect.size.width = fullScreenCell.fullscreenImageView.frame.size.width / scale
//
//        let newCenter = fullScreenCell.fullscreenImageView.convert(center, from: fullscreenCollectionView)
//        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
//        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
//        return zoomRect
//    }
   
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
