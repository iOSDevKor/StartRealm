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
        //=====================================================//
        //                      Realm Migration                //
        //====================================================//
//        let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
//            if oldSchemaVersion < 1 {
//                migration.enumerateObjects(ofType: Album.className(), { (oldObject, newObject) in
//                    if oldSchemaVersion < 1 {
//                        let uuid = UUID().uuidString
//                        newObject?["uuid"] = uuid
//                    }
//                })
//                migration.enumerateObjects(ofType: Photo.className()) { oldObject, newObject in
//                    if oldSchemaVersion < 1 {

//                    }
//                }
            
//            print("Migration complete.")
//        }
//        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 3, migrationBlock: migrationBlock)
        // default.realm 파일 경로(시뮬레이터일때만 사용가능)
        guard let url = Realm.Configuration.defaultConfiguration.fileURL else { return true }
        print("시뮬레이터일 경우: open . \(url)")
        return true
    }

}
