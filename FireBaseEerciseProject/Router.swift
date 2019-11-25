//
//  Router.swift
//  FireBaseEerciseProject
//
//  Created by EsraaGK on 11/25/19.
//  Copyright © 2019 EsraaGK. All rights reserved.
//

import Foundation
import UIKit

class Router {
  
    static var mainNavigationController: UINavigationController?
    
    static func initializeMainNavigationController()-> UINavigationController{
        
        let loginViewController = LoginViewController()
        
        mainNavigationController = UINavigationController(rootViewController: loginViewController)
        return mainNavigationController!
    }
    static func navigateToProfileViewController(){
        
    }
}
