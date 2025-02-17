//
//  BladeHomeVC.swift
//  BladeCaseSecureOpener
//
//  Created by SunTory on 2025/2/17.
//

import UIKit

class BladeHomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     @IBOutlet weak var collectionView: UICollectionView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
         collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "BladeHomeCollCell", bundle: nil), forCellWithReuseIdentifier: "BladeHomeCollCell")

    }
    
    // MARK: - UICollectionViewDataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gunData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BladeHomeCollCell", for: indexPath) as? BladeHomeCollCell else {
                 return UICollectionViewCell()
            }
            
            let category = gunData[indexPath.row]
            cell.imageView.image = UIImage(named: category.categoryImage)
            cell.nameLabel.text = category.categoryName
            
            return cell
        }
    
    // MARK: - UICollectionViewDelegate Methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedbladeion = gunData[indexPath.row]
        let quizessVC = storyboard?.instantiateViewController(withIdentifier: "BladeGunSpinVC") as! BladeGunSpinVC

        quizessVC.arrQue = selectedbladeion.guns
        quizessVC.categoryName = selectedbladeion.categoryName

        navigationController?.pushViewController(quizessVC, animated: true)
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - 10, height: collectionView.frame.size.width / 2 - 10)
      }
}

 


