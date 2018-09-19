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

let headingFont = UIFont(name: "Copperplate-Bold", size: 24.0)
let collectionTitleFont = UIFont(name: "Copperplate-Bold", size: 14.0)

let propertyHeaderText = "Properties"
let facilityHeaderText = "Options"

let optionsTableViewCellIdentifier = "optionsTableViewCellIdentifier"

let collectionViewCellIdentifier = "facilitiesCollectionViewCellIdentifier"

let imageWidth = UIScreen.main.bounds.size.width * 40.0 / 375.0
