//
//  Category.swift
//  testgrability
//
//  Created by Sebastián Gómez on 11/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    dynamic var categoryId: String?
    dynamic var name: String?
    
    override static func primaryKey() -> String? {
        return "categoryId"
    }

}