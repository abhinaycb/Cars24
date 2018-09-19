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
    
    let optionNameLabel = UILabel()
    let optionIconImageView = UIImageView()
    var optionData:Option?
    private var viewModel:MainViewModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        optionNameLabel.numberOfLines = 0
        optionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        optionIconImageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints()
       // self.selectedBackgroundView?.backgroundColor = UIColor(white: 20.0, alpha: 0.8)
    }
    
    func addConstraints() {
        self.addSubview(optionNameLabel)
        self.addSubview(optionIconImageView)
        let viewDict = ["optionNameLabel":optionNameLabel,"optionIconImageView":optionIconImageView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[optionNameLabel]-(10)-[optionIconImageView]", options: [], metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[optionNameLabel]-(10)-[optionIconImageView]", options: [.alignAllCenterY], metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint(item: optionIconImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: optionIconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: optionIconImageView, attribute: .width, relatedBy: .equal, toItem: optionIconImageView, attribute: .height, multiplier: 1.0, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectCell(enabled:Bool) {
        if(optionData?.isDisabled ?? false) {
            optionNameLabel.textColor = AppColors.disabledColor
            optionIconImageView.image = UIImage(named: (self.optionData?.icon ?? "apartment") + "Disabled")
        }else{
            if(enabled) {
                optionIconImageView.image = UIImage(named: (optionData?.icon ?? "apartment") + "Selected")
                optionNameLabel.textColor = AppColors.selectedColor
            }else{
                optionIconImageView.image = UIImage(named: optionData?.icon ?? "apartment")
                optionNameLabel.textColor = AppColors.primaryColor
            }
        }
    }
    
    
    func configureCell(option:Option?) {
        self.optionData = option
    
        optionNameLabel.text = option?.name ?? ""
        if(option?.isDisabled ?? false) {
            optionNameLabel.textColor = AppColors.disabledColor
            optionIconImageView.image = UIImage(named: (self.optionData?.icon ?? "apartment") + "Disabled")
        }else{
            if(option?.isActive ?? false) {
                optionIconImageView.image = UIImage(named: (option?.icon ?? "apartment") + "Selected")
                optionNameLabel.textColor = AppColors.selectedColor
            }else{
                optionIconImageView.image = UIImage(named: option?.icon ?? "apartment")
                optionNameLabel.textColor = AppColors.primaryColor
            }
        }
    }
}
