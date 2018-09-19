//
//  FacilityCollectionViewCell.swift
//  Cars24
//
//  Created by Coffeebeans on 18/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import UIKit

class FacilityCollectionViewCell:UICollectionViewCell {
    
    let facilityName = UILabel()
    let facilityImageView = UIImageView()
    let facilityNameFooter = UIView()
    
    private var instanceOption:Option?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        facilityName.font=collectionTitleFont
        facilityName.numberOfLines = 0
        self.layer.borderWidth = 3.0
        self.addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func showSelectedState(_ flag:Bool) {
        if(flag) {
            self.layer.borderColor = AppColors.selectedColor.cgColor
            facilityName.textColor = AppColors.selectedColor
            facilityNameFooter.backgroundColor = AppColors.selectedColor
            facilityImageView.image = UIImage(named: (instanceOption?.icon)!+"Selected")
        }else{
            self.layer.borderColor = AppColors.primaryColor.cgColor
            facilityName.textColor = AppColors.headingTextColor
            facilityNameFooter.backgroundColor = AppColors.primaryColor
            facilityImageView.image = UIImage(named: (instanceOption?.icon)!)
        }
    }
    //MARK: UI Constraint
    func addConstraints() {
        facilityName.translatesAutoresizingMaskIntoConstraints = false
        facilityImageView.translatesAutoresizingMaskIntoConstraints = false
        facilityNameFooter.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(facilityName)
        self.addSubview(facilityImageView)
        self.addSubview(facilityNameFooter)
        let viewDict = ["name":facilityName,"imageView":facilityImageView,"footerView":facilityNameFooter]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(5)-[imageView]-[name]-[footerView(3)]-|", options: [], metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[name]|", options: [], metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[footerView]-(10)-|", options: [], metrics: nil, views: viewDict))
        NSLayoutConstraint(item: facilityImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: facilityImageView, attribute: .width, relatedBy: .equal, toItem: facilityImageView, attribute: .height, multiplier: 1.0, constant: 0.0).isActive=true
         NSLayoutConstraint(item: facilityImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40).isActive=true
    }
    
    //MARK: State Update
    func configureCell(option:Option?) {
       self.instanceOption = option
       facilityName.text = option?.name ?? ""
       
       facilityName.textAlignment = .center
        if(option?.isActive ?? false){
            self.layer.borderColor = AppColors.selectedColor.cgColor
            facilityName.textColor = AppColors.selectedColor
            facilityNameFooter.backgroundColor = AppColors.selectedColor
            facilityImageView.image = UIImage(named: (option?.icon)!+"Selected")
        }else{
            self.layer.borderColor = AppColors.primaryColor.cgColor
            facilityName.textColor = AppColors.headingTextColor
            facilityNameFooter.backgroundColor = AppColors.primaryColor
            facilityImageView.image = UIImage(named: (option?.icon!)!)
        }
    }
    
}

