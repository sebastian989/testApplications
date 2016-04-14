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


extension IPadApplicationsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.applicationsList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let applicationCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        applicationCell.applicationNameLabel.text = self.applicationsList[indexPath.row].category
        
        return applicationCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! DetailApplicationViewController
        detailViewController.application = self.applicationsList[indexPath.row]
        self.presentViewController(detailViewController, animated: true, completion: nil)
    }
}
