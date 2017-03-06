//
//  AppDelegate.swift
//  Pray
//  Thanks God for all.
//  Created by 이주영, 윤지훈 on 08/07/2016.
//  Copyright © 2016 이주영, 윤지훈. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //Check the account is an online account.
    var isOnlineAccount = false
    
    //MS Azure.
    var client: MSClient?
    
    var window: UIWindow?

    let groupManagement = GroupManagement()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        //Azure
        self.client = MSClient(
            applicationURLString:"https://praying.azurewebsites.net"
        )
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let client = delegate.client!
        let item = ["Name":"Brian yoon"]
        let itemTable = client.table(withName: "PRAYERS_PROFILE")
        itemTable.insert(item) {
            (insertedItem, error) in
            if (error != nil) {
                print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror")
                print(error);
            } else {
                print("iddddddddddddddddddddddddddddddddddddddd")
                print(insertedItem!["id"])
            }
        }
        
        //Azure end
        
        let navigationController = window!.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! GroupTableViewController
        controller.groupResults = groupManagement
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveGroup()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveGroup()
    }
    
    func saveGroup() {
        groupManagement.saveGroupList()
    }

}

