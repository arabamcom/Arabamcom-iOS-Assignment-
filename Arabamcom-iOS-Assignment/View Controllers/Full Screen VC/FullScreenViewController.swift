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
    var pan = UIPanGestureRecognizer()
    var pinch = UIPinchGestureRecognizer()
    var viewCenter: CGPoint?
    var numberOfTouches: Int?
    var isZooming = false
    var gestureScale = 0.0
   
    override func viewDidLoad() {
        super.viewDidLoad()

        configureFullscreenCollectionView()
        configureGestureRecognizers()
    }
   
    //MARK: - Helper methods
    private func configureFullscreenCollectionView(){
        fullscreenCollectionView.delegate = self
        fullscreenCollectionView.dataSource = self
        fullscreenCollectionView.register(FullscreenCollectionViewCell.nib(), forCellWithReuseIdentifier: FullscreenCollectionViewCell.identifier)
    }
    
    private func configureGestureRecognizers(){
        //MARK: - Swipe down gesture
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didPanDown))
        swipeDownRecognizer.direction = .down
        fullscreenCollectionView.addGestureRecognizer(swipeDownRecognizer)
        
        self.view.isUserInteractionEnabled = true
        self.view.isMultipleTouchEnabled = true
        
        //MARK: Pan & Pinch Gesture
        pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        pinch = UIPinchGestureRecognizer(target: self, action: #selector(handleZoom(_:)))
        
        pan.delegate = self
        pinch.delegate = self
        
        self.view.addGestureRecognizer(pan)
        self.view.addGestureRecognizer(pinch)
    }
    
    //MARK: - Actions
    @objc func didPanDown(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleZoom(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            self.isZooming = true
            if gesture.state == .began && self.viewCenter == nil {
                self.viewCenter = self.view.center
            }
            
            if gesture.scale >= 1 {
                let scale = gesture.scale
                gestureScale = Double(Int(scale))
                gesture.view!.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            break;
        default:
            self.isZooming = false
            self.gestureScale = 0.0
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                gesture.view!.transform = .identity
                if self.viewCenter != nil {
                    gesture.view?.center = self.viewCenter!
                }
            })
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        if !self.isZooming {
            return
        }
        
        switch gesture.state {
        case .began, .changed:
            let translation = gesture.translation(in: self.view)
            let dX = gesture.view!.center.x + (translation.x)
            let dY = gesture.view!.center.y + (translation.y)
            
            let newCenter = CGPoint(x: gesture.view!.center.x + (translation.x * 1.5 * CGFloat(gestureScale)), y: gesture.view!.center.y + (translation.y * 1 * CGFloat(gestureScale)))
            let inBounds: Bool = dY >= 0 && dY <= self.view.frame.width && dX >= 0 && dX <= self.view.frame.height
            
            if inBounds {
                gesture.view!.center = newCenter
                gesture.setTranslation(CGPoint.zero, in: self.view)
            }
            
            break;
        default:
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                if self.viewCenter != nil {
                    gesture.view?.center = self.viewCenter!
                    
                }
                
            }) { _ in
                
            }
            break
        }
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

//MARK: - UIGestureRecognizer Delegate

extension FullScreenViewController: UIGestureRecognizerDelegate {
  
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.pinch || gestureRecognizer == self.pan {
            return true
        }
        return false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.pinch || gestureRecognizer == self.pan {
            return true
        }
        return false
    }
}
