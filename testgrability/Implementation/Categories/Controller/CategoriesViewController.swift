//
//  CategoriesViewController.swift
//  testgrability
//
//  Created by Sebastián Gómez on 11/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var categoriesPresenter: CategoriesPresenterProtocol!
    var categoriesList = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoriesPresenter = CategoriesPresenter(categoriesViewListener: self)
        self.categoriesPresenter.loadCategories()
    }
    
    private func showApplicationsController(selectedCategory: String) {
        if UI_USER_INTERFACE_IDIOM() == .Pad {
            let applicationsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("iPadApplicationsVC") as! IPadApplicationsViewController
            applicationsViewController.category = selectedCategory
            self.presentViewController(applicationsViewController, animated: true, completion: nil)
        } else {
            let applicationsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("iPhoneApplicationsVC") as! IPhoneApplicationsViewController
            applicationsViewController.category = selectedCategory
            self.presentViewController(applicationsViewController, animated: true, completion: nil)
        }
    }
}


extension CategoriesViewController : CategoriesViewListener {
    
    func displayCategories(categories: [Category]) {
        self.categoriesList = categories
        self.tableView.reloadData()
    }
}


//MARK: Table view delegate and datasource

extension CategoriesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoriesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        categoryCell.textLabel?.text = self.categoriesList[indexPath.row].name
        
        return categoryCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.showApplicationsController(self.categoriesList[indexPath.row].name!)
    }
}