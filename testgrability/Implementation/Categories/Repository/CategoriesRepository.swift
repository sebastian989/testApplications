//
//  CategoriesRepository.swift
//  testgrability
//
//  Created by Sebastián Gómez on 11/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class CategoriesRepository {
    
    static func requestRemoteData(responseHandler: (data: [String : AnyObject]?, error: String?) -> Void) {
        
        let alamofire = Alamofire.Manager.sharedInstance
        
        alamofire.request(.GET, Constants.baseURL)
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    let dataResponse = response.result.value! as! [String : AnyObject]
                    responseHandler(data: dataResponse, error: nil)
                    
                case .Failure(_):
                    responseHandler(data: nil, error: "There was an error with the network comunication.")
                }
        }
        
    }
    
    static func saveCategoriesAndAppsFromEntries(entries: [[String : AnyObject]]) {
        let realm = try! Realm()
        for index in 0..<entries.count {
            let category = Category()
            let application = Application()
            let entry = entries[index]
            
            category.categoryId = ((entry["category"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["im:id"] as? String
            category.name = ((entry["category"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["label"] as? String
            
            application.applicationId = ((entry["id"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["im:id"] as? String
            application.name = (entry["im:name"] as! [String : AnyObject])["label"]  as? String
            application.summary = (entry["summary"] as! [String : AnyObject])["label"]  as? String
            application.price = ((entry["im:price"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["amount"] as? String
            application.currency = ((entry["im:price"] as! [String : AnyObject])["attributes"] as? [String : AnyObject])!["currency"] as? String
            application.rights = (entry["rights"] as! [String : AnyObject])["label"]  as? String
            application.category = category.name
            application.smallImage = (entry["im:image"] as! [[String : AnyObject]])[0]["label"] as? String!
            application.mediumImage = (entry["im:image"] as! [[String : AnyObject]])[1]["label"] as? String!
            application.largeImage = (entry["im:image"] as! [[String : AnyObject]])[2]["label"] as? String!
            
            try! realm.write {
                realm.add(category, update: true)
                realm.add(application, update: true)
            }
        }
    }
    
    static func loadLocalData() -> [Category] {
        let realm = try! Realm()
        let localData = realm.objects(Category)
        let categories = localData.map { $0 }
        
        return categories
    }
    
}