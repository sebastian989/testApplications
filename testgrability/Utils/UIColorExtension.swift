//
//  UIColorExtension.swift
//  testgrability
//
//  Created by Sebastián Gómez on 15/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation

extension CALayer {
    
    func setBorderColorFromUIColor(color: UIColor) {
        self.borderColor = color.CGColor
    }
}