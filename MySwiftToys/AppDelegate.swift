//
//  AppDelegate.swift
//  MySwiftToys
//
//  Created by SongMengLong on 2022/11/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        self.setupRootVC()
        
        
        return true
    }

    
    /// 设置根视图
    private func setupRootVC() -> Void {
        
        guard let window = window else {
            return
        }
                               
        window.rootViewController = UINavigationController(rootViewController: FunctionListVC())
    }


}

