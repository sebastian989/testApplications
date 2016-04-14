//
//  Category.swift
//  testgrability
//
//  Created by Sebastián Gómez on 11/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation
import CoreData

class Category : NSManagedObject {
    
    @NSManaged var categoryId: String?
    @NSManaged var name: String?

}