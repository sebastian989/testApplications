//
//  Application.swift
//  testgrability
//
//  Created by Sebastián Gómez on 11/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation
import CoreData

class Application : NSManagedObject {
    
    @NSManaged var applicationId: String?
    @NSManaged var name: String?
    @NSManaged var summary: String?
    @NSManaged var price: String?
    @NSManaged var currency: String?
    @NSManaged var rights: String?
    @NSManaged var category: String?
    @NSManaged var smallImage: String?
    @NSManaged var mediumImage: String?
    @NSManaged var largeImage: String?
}
