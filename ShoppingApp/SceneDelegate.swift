//
//  SceneDelegate.swift
//  ShoppingApp
//
//  Created by Alexandr Kamyshev on 09.01.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
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

