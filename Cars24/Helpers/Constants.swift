//
//  Constants.swift
//  Cars24
//
//  Created by Coffeebeans on 18/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import UIKit

let facilitiesAndOptionsApiURL = "https://my-json-server.typicode.com/iranjith4/ad-assignment/db"

enum SceneTransitionType {
    enum PopType {
        case root
        case parent
        case vc(viewController: UIViewController)
    }
    
    case root
    case push(animated: Bool)
    case modal(animated: Bool)
    case pop(animated: Bool, level: PopType)
}

let ROW_HEIGHT:CGFloat = 90.0

struct AppColors {
    static let disabledColor:UIColor = UIColor(displayP3Red: 182.0/255.0, green: 181.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    static let selectedColor:UIColor = UIColor(displayP3Red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    static let primaryColor:UIColor = UIColor(displayP3Red: 36.0/255.0, green: 172/255.0, blue: 254.0/255.0, alpha: 1.0)
    static let headingTextColor:UIColor = UIColor(displayP3Red: 56.0/255.0, green: 125.0/255.0, blue: 198.0/255.0, alpha: 1.0)
}

var headingFont = UIFont(name: "Copperplate-Bold", size: 24.0)
var collectionTitleFont = UIFont(name: "Copperplate-Bold", size: 14.0)

struct IntConstants {
    static let imageWidth = UIScreen.main.bounds.size.width * 40.0 / 375.0
    static let tableHeight:CGFloat = 100.0
    static let collectionViewItemHeight:CGFloat = 100.0
}
let One = "1"
let Six = "6"

struct StringConstants {
    static let propertyType = "Property Type"
    static let propertyHeaderText = "Properties"
    static let facilityHeaderText = "Options"
    
    static let optionsTableViewCellIdentifier = "optionsTableViewCellIdentifier"
    static let collectionViewCellIdentifier = "facilitiesCollectionViewCellIdentifier"
    
    static let apartment = "apartment"
    static let disabled = "Disabled"
    static let selected = "Selected"
}


