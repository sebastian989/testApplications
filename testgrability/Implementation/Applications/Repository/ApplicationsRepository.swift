//
//  ApplicationsRepository.swift
//  testgrability
//
//  Created by Sebastián Gómez on 13/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation
import CoreData

class ApplicationsRepository {
    
    static func loadApplications(category: String, listener:([Application]) -> Void) {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let request = NSFetchRequest(entityName: "Application")
        request.predicate = NSPredicate(format: "category == '\(category)'")
        var result: [AnyObject]?
        do {
            result = try managedObjectContext.executeFetchRequest(request)
        } catch _ {
            result = []
        }
        listener(result as! [Application])
    }
}