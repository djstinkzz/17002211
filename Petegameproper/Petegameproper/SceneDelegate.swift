//
//  SceneDelegate.swift
//  Petestestgame
//
//  Created by Pete Smith on 08/06/2020.
//  Copyright © 2020 Pete Smith. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let _ = (scene as? UIWindowScene) else { return }
            // Fallback on earlier versions
}
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
}

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
}

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
}

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
}
}
