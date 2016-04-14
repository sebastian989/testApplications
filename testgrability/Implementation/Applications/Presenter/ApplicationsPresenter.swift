//
//  ApplicationsPresenter.swift
//  testgrability
//
//  Created by Sebastián Gómez on 13/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation

class ApplicationsPresenter {
    
    var applicationsLogic: ApplicationsLogic!
    var applicationViewListener: ApplicationsViewListener!
    
    init(applicationViewListener: ApplicationsViewListener) {
        self.applicationViewListener = applicationViewListener
        self.applicationsLogic = ApplicationsLogic(applicationsPresenterListener: self)
    }
    
}


extension ApplicationsPresenter: ApplicationsPresenterProtocol {
    
    func loadApplications(category: String) {
        self.applicationsLogic.loadApplications(category)
    }
    
}


extension ApplicationsPresenter: ApplicationsPresenterListener {
    
    func displayApplications(applications: [Application]) {
        self.applicationViewListener.displayApplications(applications)
    }
}