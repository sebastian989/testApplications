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
    var shouldAnimateTable = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoriesPresenter = CategoriesPresenter(categoriesViewListener: self)
        self.categoriesPresenter.loadCategories()
    }
    
    private func showApplicationsController(selectedCategory: String) {
        if UI_USER_INTERFACE_IDIOM() == .Pad {
            let applicationsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("iPadApplicationsVC") as! IPadApplicationsViewController
            applicationsViewController.category = selectedCategory
            self.navigationController?.pushViewController(applicationsViewController, animated: true)
        } else {
            let applicationsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("iPhoneApplicationsVC") as! IPhoneApplicationsViewController
            applicationsViewController.category = selectedCategory
            self.navigationController?.pushViewController(applicationsViewController, animated: true)
        }
    }
    
    func animateTable() {
        tableView.reloadData()
        
        if self.shouldAnimateTable && self.categoriesList.count > 0 {
            let cells = tableView.visibleCells
            let tableHeight: CGFloat = tableView.bounds.size.height
            
            for i in cells {
                let cell: UITableViewCell = i as UITableViewCell
                cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
            }
            
            var index = 0
            
            for cell in cells {
                UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
                    cell.transform = CGAffineTransformMakeTranslation(0, 0);
                    }, completion: nil)
                
                index += 1
            }
            self.shouldAnimateTable = false
        }
    }
}


extension CategoriesViewController : CategoriesViewListener {
    
    func displayCategories(categories: [Category]) {
        self.categoriesList = categories
        self.animateTable()
    }
}


//MARK: Table view delegate and datasource

extension CategoriesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoriesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CategoryTableViewCell
        categoryCell.quantityLabel.text = "\(self.categoriesList[indexPath.row].quantity!)"
        categoryCell.categoryNameLabel.text = self.categoriesList[indexPath.row].name!
        
        return categoryCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.showApplicationsController(self.categoriesList[indexPath.row].name!)
    }
}