//
//  BladeOnBoardCVC.swift
//  BladeCaseSecureOpener
//
//  Created by SunTory on 2025/2/17.
//

import UIKit

class BladeOnBoardCVC: UICollectionViewCell {

    @IBOutlet weak var viewText: UIView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblSlogen: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let fontSize = (viewText.frame.height)
        lblDesc.font = UIFont(name: "STIX Two Text SemiBold", size: fontSize/12)
        lblSlogen.font = UIFont(name: "STIX Two Text SemiBold", size: fontSize/20)
        // Initialization code
    }

}

