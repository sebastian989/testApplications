//
//  CategoriesViewController.swift
//  testgrability
//
//  Created by Sebastián Gómez on 11/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    var categoriesPresenter: CategoriesPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoriesPresenter = CategoriesPresenter(categoriesViewListener: self)
        self.categoriesPresenter.loadCategories()
    }
    

}


extension CategoriesViewController : CategoriesViewListener {
    
    func displayCategories(categories: [Category]) {
        
    }
}
