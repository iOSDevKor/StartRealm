//
//  StartRealm.swift
//  StartRealm
//
//  Created by Mijeong Jeon on 20/03/2017.
//  Copyright © 2017 Jo Seong Gyu. All rights reserved.
//

import Foundation
import RealmSwift

class AlbumList: Object {
    dynamic var title: String = ""
// 마이그레이션할때 추가할 것
//    dynamic var subTitle: String = ""
    dynamic var createDate: Date = Date()
    let photoList: List<PhotoList> = List<PhotoList>()
}

class PhotoList: Object {
    dynamic var createDate: Date = Date()
    dynamic var image: Data = Data()
}
