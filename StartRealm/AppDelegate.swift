//
//  AppDelegate.swift
//  StartRealm
//
//  Created by keyWindow on 2017. 2. 15..
//  Copyright © 2017년 keyWindow. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 렘 마이그레이션
//        let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
//            if oldSchemaVersion < 1 {
//                migration.enumerateObjects(ofType: AlbumList.className(), { (oldObject, newObject) in
//                    if oldSchemaVersion < 1 {
//                    }
//                })
//                migration.enumerateObjects(ofType: PhotoList.className()) { oldObject, newObject in
//                    if oldSchemaVersion < 1 {
//                        // combine name fields into a single field
//                        let detailTitle = oldObject!["detailTitle"] as! String
//                            newObject?["memo"] = "\(detailTitle)"
//                    }
//                }
//            }
//            print("Migration complete.")
//        }
//        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 0, migrationBlock: migrationBlock)

        return true
    }

}

