//
//  CategoriesLogic.swift
//  testgrability
//
//  Created by Sebastián Gómez on 11/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation

class CategoriesLogic {
    
    let categoryPresenterListener: CategoriesPresenterListener!
    var categories = [Category]()
    
    
    init(presenterListener: CategoriesPresenterListener) {
        self.categoryPresenterListener = presenterListener
    }
    
    func loadCategories() {
        CategoriesRepository.requestRemoteData(onAPIResponse)
        self.loadSavedCategories()
    }
    
    private func loadSavedCategories() {
        self.categories = CategoriesRepository.loadLocalData()
        self.sortCategories()
        self.categoryPresenterListener.displayCategories(self.categories)
    }
    
    private func sortCategories() {
        self.categories.sortInPlace { (categoryA, categoryB) -> Bool in
            return categoryA.name < categoryB.name
        }
    }
    
    
    //MARK: Network response handler functions
    
    func onAPIResponse(data: [String : AnyObject]?, errorMessage: String?) {
        if errorMessage == nil {
            self.parseResponseJSon(data!)
        } else {
            
        }
    }
    
    func parseResponseJSon(json: [String : AnyObject]) {
        if let updatedField = (json["feed"] as! [String : AnyObject])["updated"] {
            let remoteDataLastUpdate = (updatedField as! [String : String])["label"]
            if self.getLastSyncDate() != remoteDataLastUpdate {
                let entries = (json["feed"] as! [String : AnyObject])["entry"] as! [[String : AnyObject]]
                CategoriesRepository.removeAllDBObjects(["Application", "Category"])
                CategoriesRepository.saveCategoriesAndAppsFromEntries(entries)
                self.saveLastSyncDate(remoteDataLastUpdate!)
                self.loadSavedCategories()
            }
        }
    }
    
    func getLastSyncDate() -> String {
        if let lastSyncDate = NSUserDefaults.standardUserDefaults().objectForKey(Constants.lastSyncDate) as? String {
            return lastSyncDate
        }
        return ""
    }
    
    func saveLastSyncDate(lastUpdate: String) {
        NSUserDefaults.standardUserDefaults().setValue(lastUpdate, forKey: Constants.lastSyncDate)
    }
    
}