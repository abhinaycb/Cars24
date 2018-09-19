//
//  OptionsTableViewCell.swift
//  Cars24
//
//  Created by Coffeebeans on 18/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import UIKit

class OptionsTableViewCell:UITableViewCell {
    
    //MARK: Properties
    let optionNameLabel = UILabel()
    let optionIconImageView = UIImageView()
    
    var optionData:Option?
    private var viewModel:MainViewModel?
    var viewDict:[String:Any]?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.layer.borderWidth = 3.0
        
        optionNameLabel.numberOfLines = 0
        
        optionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        optionIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        viewDict = ["optionNameLabel":optionNameLabel,"optionIconImageView":optionIconImageView]
        addConstraints()
    }
    
    
    //MARK:Constraints
    func addConstraints() {
        self.addSubview(optionNameLabel)
        self.addSubview(optionIconImageView)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[optionNameLabel]-(10)-[optionIconImageView]", options: [], metrics: nil, views: viewDict!))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[optionNameLabel]-(10)-[optionIconImageView]", options: [.alignAllCenterY], metrics: nil, views: viewDict!))
        
        self.addConstraint(NSLayoutConstraint(item: optionIconImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: optionIconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        self.addConstraint(NSLayoutConstraint(item: optionIconImageView, attribute: .width, relatedBy: .equal, toItem: optionIconImageView, attribute: .height, multiplier: 1.0, constant: 0.0))
         self.addConstraint(NSLayoutConstraint(item: optionIconImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Updated to change cells color
    func selectCell(enabled:Bool) {
        if(optionData?.isDisabled ?? false) {
            self.layer.borderColor = AppColors.disabledColor.cgColor
            optionNameLabel.textColor = AppColors.disabledColor
            optionIconImageView.image = UIImage(named: (self.optionData?.icon ?? StringConstants.apartment) + StringConstants.disabled)
        }else{
            if(enabled) {
                self.layer.borderColor = AppColors.selectedColor.cgColor
                optionIconImageView.image = UIImage(named: (optionData?.icon ?? StringConstants.apartment) + StringConstants.selected)
                optionNameLabel.textColor = AppColors.selectedColor
            }else{
                optionIconImageView.image = UIImage(named: optionData?.icon ?? StringConstants.apartment)
                optionNameLabel.textColor = AppColors.primaryColor
                self.layer.borderColor = AppColors.primaryColor.cgColor
            }
        }
    }
    //MARK: Configure Cell whenever data is changed (Updating State)
    func configureCell(option:Option?) {
        self.optionData = option
    
        optionNameLabel.text = option?.name ?? ""
        if(option?.isDisabled ?? false) {
            optionNameLabel.textColor = AppColors.disabledColor
            optionIconImageView.image = UIImage(named: (self.optionData?.icon ?? StringConstants.apartment) + StringConstants.disabled)
            self.layer.borderColor = AppColors.disabledColor.cgColor
        }else{
            if(option?.isActive ?? false) {
                optionIconImageView.image = UIImage(named: (option?.icon ?? StringConstants.apartment) + StringConstants.selected)
                optionNameLabel.textColor = AppColors.selectedColor
                self.layer.borderColor = AppColors.selectedColor.cgColor
            }else{
                optionIconImageView.image = UIImage(named: option?.icon ?? StringConstants.apartment)
                optionNameLabel.textColor = AppColors.primaryColor
                self.layer.borderColor = AppColors.primaryColor.cgColor
            }
        }
    }
}
