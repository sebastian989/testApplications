//
//  DetailApplicationViewController.swift
//  testgrability
//
//  Created by Sebastián Gómez on 13/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import UIKit

class DetailApplicationViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rightsLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    var application: Application!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    private func setupView() {
        self.nameLabel.text = self.application.name
        self.rightsLabel.text = self.application.rights
        self.summaryLabel.text = self.application.summary
        let url = NSURL(string: self.application.largeImage!)
        self.imageView.sd_setImageWithURL(url)
    }
    
    @IBAction func backButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
