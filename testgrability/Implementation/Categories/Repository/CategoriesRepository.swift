//
//  CategoriesRepository.swift
//  testgrability
//
//  Created by Sebastián Gómez on 11/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation
import CoreData

class CategoriesRepository {
    
    static func requestRemoteData(responseHandler: (data: [String : AnyObject]?, error: String?) -> Void) {
        
        let manager = AFHTTPSessionManager()
        
        manager.GET(Constants.baseURL, parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, dataResponse: AnyObject?) in
            responseHandler(data: dataResponse as? [String:AnyObject], error: nil)
        }) { (operation: NSURLSessionDataTask?, error: NSError) in
            responseHandler(data: nil, error: "There was an error with the network comunication.")
        }
    }
    
    
    static func saveCategoriesAndAppsFromEntries(entries: [[String : AnyObject]]) {
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        for index in 0..<entries.count {
            let entry = entries[index]
            updateOrCreateCategory(entry, managedObjectContext: managedObjectContext)
            updateOrCreateApplication(entry, managedObjectContext: managedObjectContext)
        }
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
    
    
    static func getObjectByCustomId(id: String) -> NSManagedObject? {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let request = NSFetchRequest(entityName: "Category")
        request.predicate = NSPredicate(format: "categoryId == '\(id)'")
        var result: [AnyObject]?
        do {
            result = try managedObjectContext.executeFetchRequest(request)
        } catch _ {
            result = nil
        }
        return result!.first as? NSManagedObject
    }
    
    
    static func updateOrCreateCategory(entry: [String : AnyObject], managedObjectContext: NSManagedObjectContext) {
        let categoryId = ((entry["category"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["im:id"] as? String
        
        var category: Category? = getObjectByCustomId(categoryId!) as? Category
        
        if category == nil {
            category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as? Category
        }
        
        category!.categoryId = categoryId!
        category!.name = ((entry["category"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["label"] as? String
    }
    
    
    static func updateOrCreateApplication(entry: [String : AnyObject], managedObjectContext: NSManagedObjectContext) {
        let applicationId = ((entry["id"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["im:id"] as? String
        
        var application: Application? = getObjectByCustomId(applicationId!) as? Application
        
        if application == nil {
            application = NSEntityDescription.insertNewObjectForEntityForName("Application", inManagedObjectContext: managedObjectContext) as? Application
        }
        
        application!.applicationId = applicationId
        application!.name = (entry["im:name"] as! [String : AnyObject])["label"]  as? String
        application!.summary = (entry["summary"] as! [String : AnyObject])["label"]  as? String
        application!.price = ((entry["im:price"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["amount"] as? String
        application!.currency = ((entry["im:price"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["currency"] as? String
        application!.rights = (entry["rights"] as! [String : AnyObject])["label"]  as? String
        application!.category = ((entry["category"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["label"] as? String
        application!.smallImage = (entry["im:image"] as! [[String : AnyObject]])[0]["label"] as? String!
        application!.mediumImage = (entry["im:image"] as! [[String : AnyObject]])[1]["label"] as? String!
        application!.largeImage = (entry["im:image"] as! [[String : AnyObject]])[2]["label"] as? String!
    }
    
    
    static func loadLocalData() -> [Category] {
        let fetchRequest = NSFetchRequest(entityName: "Category")
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Category]
            return results
        } catch {
            return []
        }
    }
    
}