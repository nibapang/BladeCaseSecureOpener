//
//  BladeGunSpinVC.swift
//  BladeCaseSecureOpener
//
//  Created by SunTory on 2025/2/17.
//

import UIKit

class BladeGunSpinVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var spinCollectionView: UICollectionView!
    @IBOutlet weak var allGunsCollectionView: UICollectionView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var spinCounterLabel: UILabel!
    @IBOutlet weak var CategoryName: UILabel!
    
    var arrQue: [Gun] = []
    var selectedGun: Gun?
    var categoryName: String = "Gun"
    var spinTimer: Timer?
    var isAlertDisplayed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViews()
        setupUI()
        updateSpinStatus()
        CategoryName.text = categoryName
        
        // Start a timer to update the spin status every minute
        spinTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateSpinStatus), userInfo: nil, repeats: true)
    }
    
    private func setupCollectionViews() {
        spinCollectionView.delegate = self
        spinCollectionView.dataSource = self
        spinCollectionView.register(UINib(nibName: "BladeGunCell", bundle: nil), forCellWithReuseIdentifier: "BladeGunCell")
        
        allGunsCollectionView.delegate = self
        allGunsCollectionView.dataSource = self
        allGunsCollectionView.register(UINib(nibName: "BladeGunCell", bundle: nil), forCellWithReuseIdentifier: "BladeGunCell")
    }
    
    private func setupUI() {
        spinButton.setTitle("Spin", for: .normal)
        spinButton.layer.cornerRadius = 8
        spinButton.addTarget(self, action: #selector(spinButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Spin Button Action
    
    @objc func spinButtonTapped() {
        if SpinManager.shared.attemptSpin() {
            performSpin()
        } else {
            showNoSpinsAlert()
        }
        updateSpinStatus()
    }
    
    private func performSpin() {
        guard !arrQue.isEmpty else { return }
        
        let randomIndex = Int.random(in: 0..<arrQue.count)
        selectedGun = arrQue[randomIndex]
        let indexPath = IndexPath(item: randomIndex, section: 0)
        spinCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Save the gun only when spun
            self.saveCollectedItem(self.selectedGun!, key: "CollectedGuns")
            
            // Show alert after saving
            self.showSelectedGunAlert(gun: self.selectedGun!)
        }
    }
    
    private func showSelectedGunAlert(gun: Gun) {
        guard !isAlertDisplayed else { return }
        isAlertDisplayed = true

        // Alert View Setup
        let alertView = UIView(frame: CGRect(x: 20, y: self.view.frame.height / 2 - 150, width: self.view.frame.width - 40, height: 300))
        alertView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        alertView.layer.cornerRadius = 15
        alertView.layer.borderWidth = 2
        alertView.layer.borderColor = UIColor.black.cgColor
        alertView.clipsToBounds = true
        alertView.tag = 999

        // Gun Image
        let gunImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 80, height: 80))
        gunImageView.image = UIImage(named: gun.images)
        gunImageView.contentMode = .scaleAspectFit
        alertView.addSubview(gunImageView)

        // Gun Details Label (Name, Price, Rarity)
        let gunDetailsLabel = UILabel(frame: CGRect(x: 100, y: 10, width: alertView.frame.width - 110, height: 80))
        gunDetailsLabel.numberOfLines = 0
        gunDetailsLabel.text = "Name: \(gun.name)\nPrice: \(gun.price)\nRarity: \(gun.rarity)"
        gunDetailsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        alertView.addSubview(gunDetailsLabel)

        // Gun Description Label
        let gunDescLabel = UILabel(frame: CGRect(x: 10, y: 100, width: alertView.frame.width - 20, height: 130))
        gunDescLabel.numberOfLines = 0
        gunDescLabel.lineBreakMode = .byWordWrapping
        gunDescLabel.text = "Description: \(gun.description)"
        gunDescLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        alertView.addSubview(gunDescLabel)

        // OK Button (Dismiss only)
        let okButton = UIButton(frame: CGRect(x: 20, y: alertView.frame.height - 50, width: alertView.frame.width - 40, height: 40))
        okButton.setTitle("OK", for: .normal)
        okButton.backgroundColor = .systemGreen
        okButton.setTitleColor(.white, for: .normal)
        okButton.layer.cornerRadius = 10
        okButton.addTarget(self, action: #selector(dismissAlert(_:)), for: .touchUpInside)
        alertView.addSubview(okButton)

        self.view.addSubview(alertView)
    }
    
    // MARK: - Save Collected Gun
    
    private func saveCollectedItem(_ item: Gun, key: String) {
        var collectedItems = loadCollectedItems(forKey: key)
        
        // Check if the gun already exists in the collected items
        if !collectedItems.contains(where: { $0.name == item.name }) {
            collectedItems.append(item)
            
            if let encoded = try? JSONEncoder().encode(collectedItems) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        } else {
            print("Gun already collected: \(item.name)")
        }
    }
    
    private func loadCollectedItems(forKey key: String) -> [Gun] {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decodedItems = try? JSONDecoder().decode([Gun].self, from: savedData) {
            return decodedItems
        }
        return []
    }
    
    @objc private func dismissAlert(_ sender: UIButton) {
        if let alertView = self.view.viewWithTag(999) {
            alertView.removeFromSuperview()
        }
        isAlertDisplayed = false  // Reset the flag when alert is dismissed
    }
    
    private func showNoSpinsAlert() {
        guard !isAlertDisplayed else { return }  // Prevent multiple alerts
        isAlertDisplayed = true  // Set alert as displayed
        
        let timeRemaining = SpinManager.shared.timeUntilNextReset()
        let minutes = Int(timeRemaining) / 60
        let message = "No spins left! Spins will reset in \(minutes) minutes."
        
        let alert = UIAlertController(title: "Out of Spins", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.isAlertDisplayed = false
        }))
        present(alert, animated: true)
    }
    
    // MARK: - Update Spin Status
    
    @objc private func updateSpinStatus() {
        let remainingSpins = SpinManager.shared.remainingSpins
        if remainingSpins > 0 {
            spinCounterLabel.text = "Spins Left: \(remainingSpins)"
            spinButton.isEnabled = true
            spinButton.alpha = 1.0
        } else {
            let timeRemaining = SpinManager.shared.timeUntilNextReset()
            let minutes = Int(timeRemaining) / 60
            spinCounterLabel.text = "Next spins in: \(minutes) min"
            spinButton.isEnabled = false
            spinButton.alpha = 0.5
        }
    }
    
    // MARK: - UICollectionView DataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrQue.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BladeGunCell", for: indexPath) as? BladeGunCell else {
            return UICollectionViewCell()
        }
        
        let gun = arrQue[indexPath.item]
        cell.gunImageView.image = UIImage(named: gun.images)
        cell.gunNameLabel.text = gun.name
        cell.gunPriceLabel.text = gun.price
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == spinCollectionView {
            return CGSize(width: collectionView.frame.width * 0.6 - 10, height: collectionView.frame.height)
        } else {
            let width = (collectionView.frame.width / 2 - 10)
            return CGSize(width: width, height: 160)
        }
    }
    
    // MARK: - UICollectionViewDelegate Methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGun = arrQue[indexPath.item]
        
        // Just show the gun details, do not save
        showSelectedGunAlert(gun: selectedGun)
    }
}
