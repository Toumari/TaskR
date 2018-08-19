//
//  Item.swift
//  TaskR
//
//  Created by Jack Williams on 14/08/2018.
//  Copyright © 2018 Jack Williams. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
