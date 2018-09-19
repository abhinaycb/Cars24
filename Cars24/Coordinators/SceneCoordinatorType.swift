//
//  SceneCoordinatorType.swift
//  Cars24
//
//  Created by Coffeebeans on 18/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation

//
//  SceneCoordinatorType.swift
//  MoneyTap
//
//  Created by Abhinay Varma on 15/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol SceneCoordinatorType {
    init(window: UIWindow)
    
    var currentViewController: UIViewController? { get set }
    
    @discardableResult
    func transition(to scene: Navigationable, type: SceneTransitionType) -> Completable
}
