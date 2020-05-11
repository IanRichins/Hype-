//
//  Date Extension.swift
//  Hype!
//
//  Created by Ian Richins on 5/10/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import Foundation


extension Date {

func stringValue() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
        
    return formatter.string(from: self)
    
    }
}
