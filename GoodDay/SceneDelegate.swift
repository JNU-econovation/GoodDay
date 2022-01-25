//
//  SceneDelegate.swift
//  GoodDay
//
//  Created by LIMCHEASUENG on 2021/12/30.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let db = Firestore.firestore()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let userDefaults = UserDefaults.standard
        //userDefaults.set(false, forKey: "isInitialized")
        let isInitialized: Bool = userDefaults.bool(forKey: "isInitialized")
//        let isInitialized: Bool = false
        
//        goChecklist()
//        return
        
        // 초기 설정이 안 됐을 경우 -> 초기 화면으로 이동
        if !isInitialized {
            let WelcomeVC = WelcomeViewController(nibName: "WelcomeViewController", bundle: nil)
            
            window?.rootViewController = WelcomeVC
            
            
        } else {
            // 초기 설정이 됐을 경우 -> 메인 화면으로 이동
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let mainVC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
             
            window?.rootViewController = mainVC
            
        }
    }
    
    func goChecklist() {
        let beginDate = UserDefaults.standard.object(forKey: "beginDay") as! Date
        //let isDoChecklist = UserDefaults.standard.bool(forKey: "isDoChecklist")
        let isDoChecklist = false
        //let curDay = Calendar.current.dateComponents([.day], from: beginDate, to: Date()).day! + 1
        let curDay = 7
        
        if (curDay % 7 == 0) && !isDoChecklist {
            let GDChecklistVC = GDChecklistViewController(nibName: "GDChecklist1", bundle: nil)
            
            window?.rootViewController = GDChecklistVC
            
            UserDefaults.standard.set(true, forKey: "isDoChecklist")
        }
        
        if curDay % 7 != 0 {
            UserDefaults.standard.set(false, forKey: "isDoChecklist")
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

