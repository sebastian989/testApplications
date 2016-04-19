//
//  IPhoneApplicationsViewController.swift
//  testgrability
//
//  Created by Sebastián Gómez on 13/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import UIKit

class IPhoneApplicationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var applicationPresenter: ApplicationsPresenterProtocol!
    var applicationsList = [Application]()
    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.category
        self.applicationPresenter = ApplicationsPresenter(applicationViewListener: self)
        self.applicationPresenter.loadApplications(self.category)
    }
}


extension IPhoneApplicationsViewController: ApplicationsViewListener {
    
    func displayApplications(applications: [Application]) {
        self.applicationsList = applications
        self.tableView.reloadData()
    }
}


extension IPhoneApplicationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.applicationsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let applicationCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        
        let selectedApplication = self.applicationsList[indexPath.row]
        
        applicationCell.applicationNameLabel.text = selectedApplication.name!
        applicationCell.rightsLabel.text = selectedApplication.rights!
        let priceText = "\(selectedApplication.price!) \(selectedApplication.currency)"
        applicationCell.priceLabel.text = Float(selectedApplication.price!) > 0 ? priceText : "Free"
        let url = NSURL(string: selectedApplication.mediumImage!)
        
        applicationCell.applicationImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "Placeholder")) { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, url: NSURL!) in
            
            let sprintAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            sprintAnimation.toValue = NSValue(CGPoint: CGPointMake(0.9, 0.9))
            sprintAnimation.velocity = NSValue(CGPoint: CGPointMake(2, 2))
            sprintAnimation.springBounciness = 20;
            applicationCell.applicationImageView.pop_addAnimation(sprintAnimation, forKey: "springAnimation")
        }
        
        return applicationCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! DetailApplicationViewController
        detailViewController.application = self.applicationsList[indexPath.row]
        self.presentViewController(detailViewController, animated: true, completion: nil)
    
    }
}