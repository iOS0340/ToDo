//
//  AppDelegate.swift
//  ToDo
//
//  Created by Bhavesh Patel on 24/06/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    
    static var sharedObject : AppDelegate {
        
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
            
            // Pass the data model filename to the container’s initializer.
            let container = NSPersistentContainer(name: "ToDo")
            
            // Load any persistent stores, which creates a store if none exists.
            container.loadPersistentStores { _, error in
                if let error {
                    // Handle the error appropriately. However, it's useful to use
                    // `fatalError(_:file:line:)` during development.
                    fatalError("Failed to load persistent stores: \(error.localizedDescription)")
                }
            }
            return container
        }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func saveContext() throws -> Void{
            // Verify that the context has uncommitted changes.
            guard persistentContainer.viewContext.hasChanges else { return }
            
            do {
                // Attempt to save changes.
                try persistentContainer.viewContext.save()
            } catch {
                // Handle the error appropriately.
                throw error
            }
        
        }

}

