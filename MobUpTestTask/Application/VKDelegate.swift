//
//  VKDelegate.swift
//  MobileUp's test task
//
//  Created by Федор Еронин on 07.04.2022.
//

import SwiftyVK
import UIKit

var vkDelegate: SwiftyVKDelegate?

class VKDelegate: SwiftyVKDelegate {
    
    //Set up SwiftyVK framework for use
    
    let appID = "8131820"
    let scopes: Scopes = []
    
    init() {
        VK.setUp(appId: appID, delegate: self)
    }

    func vkNeedsScopes(for sessionId: String) -> Scopes {

        return scopes
    }

        //add VK Auth window 
    func vkNeedToPresent(viewController: VKViewController) {
        if let rootController = UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController {
            rootController.present(viewController, animated: true)
        }
    }

    func vkTokenCreated(for sessionId: String, info: [String : String]) {
      
    }

    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
      
    }

    func vkTokenRemoved(for sessionId: String) {
  
    }
}
