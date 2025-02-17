//
//  BladeOnBoardVC.swift
//  BladeCaseSecureOpener
//
//  Created by SunTory on 2025/2/17.
//

import UIKit
import Reachability

class BladeOnBoardVC: UIViewController {
    
    //MARK: - Declare IBOutlets
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var onBoardCollectionView: UICollectionView!
    
    @IBOutlet weak var bladeCctivityIndicator: UIActivityIndicatorView!
    var bladeReachability: Reachability!
    //MARK: - Declare Variables
    var arrImages = [String]()
    var arrSlogen = [String]()
    var arrDesc = [String]()
    var previousPage: CGFloat = 0
    
    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        self.bladeCctivityIndicator.hidesWhenStopped = true
        bladeLoadAdsBannerData()
    }
    private func bladeLoadAdsBannerData() {
        guard bladeNeedShowBannerDescView() else {
          
            return
        }
                
        do {
            bladeReachability = try Reachability()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        if bladeReachability.connection == .unavailable {
            bladeReachability.whenReachable = { reachability in
                self.bladeReachability.stopNotifier()
                self.bladeRequestAdsBannerData()
            }

            bladeReachability.whenUnreachable = { _ in
            }

            do {
                try bladeReachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        } else {
            self.bladeRequestAdsBannerData()
        }
    }

    private func bladeRequestAdsBannerData() {
        self.bladeCctivityIndicator.startAnimating()
        
        guard let bundleId = Bundle.main.bundleIdentifier else {
            return
        }
        
        let url = URL(string: "https://open.yudf\(self.bladeFusionMainHostName())/open/bladeReqAdsBannerData")!
        var Request = URLRequest(url: url)
        Request.httpMethod = "POST"
        Request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "appSystemName": UIDevice.current.systemName,
            "appModelName": UIDevice.current.model,
            "appKey": "76136334c05545b49e69736228c1396d",
            "appPackageId": bundleId,
            "appVersion": "com.app.blade.BladeCaseSecureOpener"
        ]

        do {
            Request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON:", error)
            return
        }

        let task = URLSession.shared.dataTask(with: Request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Request error:", error ?? "Unknown error")
                    self.bladeCctivityIndicator.stopAnimating()
            
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any] {
                        let dictionary: [String: Any]? = resDic["data"] as? Dictionary
                        if let dataDic = dictionary {
                            if let adsData = dataDic["jsonObject"] as? [String: Any], let bannData = adsData["bannerData"] as? String {
                                self.bladeShowBannerDescView(bnUrl: bannData)
                                return
                            }
                        }
                    }
                    print("Response JSON:", jsonResponse)
                    self.bladeCctivityIndicator.stopAnimating()
                
                } catch {
                    print("Failed to parse JSON:", error)
                    self.bladeCctivityIndicator.stopAnimating()
                 
                }
            }
        }

        task.resume()
    }
    
    private func bladeShowBannerDescView(bnUrl: String) {
        let vc: BladePrivacyVC = self.storyboard?.instantiateViewController(withIdentifier: "BladePrivacyVC") as! BladePrivacyVC
        vc.modalPresentationStyle = .fullScreen
        vc.url = bnUrl
        self.navigationController?.present(vc, animated: false)
    }
    
    //MARK: - Functions
    func setUpCollectionView() {
        arrImages = ["1","2","3","4"]
        
        arrSlogen = ["Armory Awaits: Spin for Glory!","Spin the Barrel: Collect, Conquer, Dominate!","Legendary Guns, One Spin Away!","Spin, Unlock, Rule the Armory!"]
        
        arrDesc = ["Dive into the ultimate gun collection challenge! Spin the wheel, unlock legendary weapons, and build your arsenal of rare snipers, pistols, and more. Are you ready to become the ultimate collector?","Test your luck and strguategy! Spin to unlock powerful firearms, from iconic snipers to rare pistols. Will you score the legendary MG42 or the elusive Barrett M82? The battlefield is yours to command!","Enter the world of elite weaponry! Spin to collect rare and epic guns, from precision rifles to tactical shotguns. Every spin brings you closer to the ultimate arsenal. Ready to lock, load, and dominate?","Your weapon collection journey begins here! Spin for legendary sniper rifles, powerful assault weapons, and rare knives. Collect them all and become the master of the arsenal!"]
        
        self.onBoardCollectionView.dataSource = self
        self.onBoardCollectionView.delegate = self
        self.onBoardCollectionView.register(UINib(nibName: "BladeOnBoardCVC", bundle: nil), forCellWithReuseIdentifier: "BladeOnBoardCVC")
    }
    
    //MARK: - Declare IBAction
    @IBAction func btnSkip(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TabbaraVC") as? TabbaraVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Datasource and Delegate Methods
extension BladeOnBoardVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BladeOnBoardCVC", for: indexPath) as? BladeOnBoardCVC else { return UICollectionViewCell()}
        cell.imgView.image = UIImage(named: arrImages[indexPath.item])
        cell.lblSlogen.text = arrSlogen[indexPath.item]
        cell.lblDesc.text = arrDesc[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
        
        if previousPage != CGFloat(currentPage) {
            pageControl.currentPage = currentPage
            previousPage = CGFloat(currentPage)
        }
    }
}
