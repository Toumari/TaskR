//
//  Category.swift
//  TaskR
//
//  Created by Jack Williams on 14/08/2018.
//  Copyright © 2018 Jack Williams. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var colour : String = ""
    let items = List<Item>()
    
}
