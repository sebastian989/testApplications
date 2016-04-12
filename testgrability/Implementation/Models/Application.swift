//
//  Application.swift
//  testgrability
//
//  Created by Sebastián Gómez on 11/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation
import RealmSwift

class Application : Object {
    
    dynamic var applicationId: String?
    dynamic var name: String?
    dynamic var summary: String?
    dynamic var price: String?
    dynamic var currency: String?
    dynamic var rights: String?
    dynamic var category: String?
    dynamic var smallImage: String?
    dynamic var mediumImage: String?
    dynamic var largeImage: String?
    
    override static func primaryKey() -> String? {
        return "applicationId"
    }
}
