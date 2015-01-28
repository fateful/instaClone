//
//  AppDelegate.swift
//  InstaClone
//
//  Created by DeviOS on 14/01/15.
//  Copyright (c) 2015 DeviOS. All rights reserved.
//

import UIKit
import Parse
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        
        Parse.setApplicationId("LoJjKrjV93i3TaV8NQI3Jcu7P5kX2W1dUkrN1O9i"
             , clientKey: "36po5IXqlPQBbcH3RZZEJvUEqknUSHJnDYNL0mkJ")
        
//        let foto = PFObject(className: "Fotos")
//        foto.setObject("Foto legal",forKey:"titulo")
//        foto.setObject("01/01/2014", forKey: "data")
//        foto.saveInBackgroundWithBlock{(sucesso:Bool!, erro: NSError!) -> Void in
        
            
            
//        }
        
        
        let query = PFQuery(className: "Fotos")
        query.getObjectInBackgroundWithId("FzGhxdVtML", block: {(foto: PFObject!, erro:NSError!) -> Void in
        if let umaFoto = foto {
            println("legal")
            umaFoto.valueForKey("titulo")
            
            umaFoto.setObject("update", forKey: "titulo")
            
//            umaFoto["titulo"] = "update!!!"
            umaFoto.saveEventually()
            
            }
        })
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

