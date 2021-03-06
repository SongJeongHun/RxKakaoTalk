//
//  AppDelegate.swift
//  RxKakaoTalk
//
//  Created by 송정훈 on 2021/01/04.
//

import UIKit
import RxKakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        RxKakaoSDKCommon.initSDK(appKey: "d0743c047005f9a628a6eb30a1e417b5")
        let coordinator = SceneCoordinator(window: window!)
        let loginVM = LoginViewModel(sceneCoordinator: coordinator)
        let loginScene = Scene.login(loginVM)
        coordinator.transition(to: loginScene, using: .root, animated: true)
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        SocketIOManager.shared.establishConnection()
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        SocketIOManager.shared.closeConnection()
    }
    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

