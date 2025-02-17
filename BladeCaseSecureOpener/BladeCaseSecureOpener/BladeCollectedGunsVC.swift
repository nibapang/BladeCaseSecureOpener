//
//  BladeCollectedGunsVC.swift
//  BladeCaseSecureOpener
//
//  Created by SunTory on 2025/2/17.
//

import UIKit

class BladeCollectedGunsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var collectedGuns: [Gun] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BladeGunCell", bundle: nil), forCellWithReuseIdentifier: "BladeGunCell")
        
        loadCollectedGuns()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCollectedGuns()
    }
    
    private func loadCollectedGuns() {
        if let savedData = UserDefaults.standard.data(forKey: "CollectedGuns"),
           let decodedGuns = try? JSONDecoder().decode([Gun].self, from: savedData) {
            collectedGuns = decodedGuns
        }
        collectionView.reloadData()
    }
    
    // MARK: - Collection View DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectedGuns.isEmpty ? 1 : collectedGuns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BladeGunCell", for: indexPath) as? BladeGunCell else {
            return UICollectionViewCell()
        }
        
        if collectedGuns.isEmpty {
            // Display a message when no guns are collected
            cell.gunImageView.image = UIImage(named: "ic_icon")
            cell.gunNameLabel.text = "No Guns Collected"
            cell.gunPriceLabel.text = "Collect First"
        } else {
            let gun = collectedGuns[indexPath.item]
            cell.gunImageView.image = UIImage(named: gun.images)
            cell.gunNameLabel.text = gun.name
            cell.gunPriceLabel.text = gun.price
        }
        return cell
    }
    
    // MARK: - Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2 - 10)
        return CGSize(width: width, height: 160)
    }
}
