//
//  IPadApplicationsViewController.swift
//  testgrability
//
//  Created by Sebastián Gómez on 13/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import UIKit

class IPadApplicationsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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


extension IPadApplicationsViewController: ApplicationsViewListener {
    
    func displayApplications(applications: [Application]) {
        self.applicationsList = applications
        self.collectionView.reloadData()
    }
}


extension IPadApplicationsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.applicationsList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let applicationCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        let selectedApplication = self.applicationsList[indexPath.row]
        applicationCell.applicationNameLabel.text = selectedApplication.name!
        applicationCell.applicationRightsLabel.text = selectedApplication.rights!
        let priceText = "\(selectedApplication.price!) \(selectedApplication.currency)"
        applicationCell.applicationPriceLabel.text = Float(selectedApplication.price!) > 0 ? priceText : "Free"
        let url = NSURL(string: selectedApplication.largeImage!)
        applicationCell.applicationImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "Placeholder")) { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, url: NSURL!) in
            
            let sprintAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            sprintAnimation.toValue = NSValue(CGPoint: CGPointMake(0.9, 0.9))
            sprintAnimation.velocity = NSValue(CGPoint: CGPointMake(2, 2))
            sprintAnimation.springBounciness = 20;
            applicationCell.applicationImageView.pop_addAnimation(sprintAnimation, forKey: "springAnimation")
        }
        
        return applicationCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! DetailApplicationViewController
        detailViewController.application = self.applicationsList[indexPath.row]
        self.presentViewController(detailViewController, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize.init(width: self.view.frame.size.width * 0.3, height: self.view.frame.size.width * 0.3)
    }
}
