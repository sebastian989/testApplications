//
//  ApplicationsLogic.swift
//  testgrability
//
//  Created by Sebastián Gómez on 13/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation

class ApplicationsLogic {
    
    var applicationsPresenterListener: ApplicationsPresenterListener!
    var applications = [Application]()
    
    init(applicationsPresenterListener: ApplicationsPresenterListener!) {
        self.applicationsPresenterListener = applicationsPresenterListener
    }
    
    func loadApplications(category: String) {
        ApplicationsRepository.loadApplications(category, listener: handleApplicationsFromDB)
    }
    
    func handleApplicationsFromDB(applications: [Application]) {
        self.applications = applications
        self.sortApplications()
        self.applicationsPresenterListener.displayApplications(self.applications)
    }
    
    private func sortApplications() {
        self.applications.sortInPlace { (applicationA, applicationB) -> Bool in
            return applicationA.name < applicationB.name
        }
    }
}