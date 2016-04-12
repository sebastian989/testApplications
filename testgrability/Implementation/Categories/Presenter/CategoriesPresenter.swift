//
//  CategoriesPresenter.swift
//  testgrability
//
//  Created by Sebastián Gómez on 11/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation

class CategoriesPresenter {
    
    var categoriesLogic: CategoriesLogic!
    var categoriesViewListener: CategoriesViewListener!
    
    init(categoriesViewListener: CategoriesViewListener) {
        self.categoriesViewListener = categoriesViewListener
        self.categoriesLogic = CategoriesLogic(presenterListener: self)
    }
    
}


extension CategoriesPresenter : CategoriesPresenterProtocol {
    
    func loadCategories() {
        self.categoriesLogic.loadCategories()
    }
}


extension CategoriesPresenter : CategoriesPresenterListener {
    
    func displayCategories(categories: [Category]) {
        self.categoriesViewListener.displayCategories(categories)
    }
    
}