//
//  Hype.swift
//  Hype!
//
//  Created by Ian Richins on 5/10/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import Foundation
import CloudKit

struct HypeStrings {
    static let recordTypeKey = "Hype"
    fileprivate static let bodyKey = "body"
    fileprivate static let timeStampKey = "timeStamp"
}

class Hype {
    let body: String
    let timeStamp: Date
    
    init(body: String, timeStamp: Date = Date()) {
        
    self.body = body
    self.timeStamp = timeStamp
    }
}

// Taking a retreived CKRecord, taking out the values found to initialize our Hype model.
extension Hype {
    convenience init?(ckRecord: CKRecord) {
        guard let body = ckRecord[HypeStrings.bodyKey] as? String,
            let timestamp = ckRecord[HypeStrings.timeStampKey] as? Date
        else { return nil }
        
        self.init(body: body, timeStamp: timestamp)
    }
}
/*
 packaging Hype model properties to be stored in a CkRecord and saved to the cloud
 */

extension CKRecord {
    convenience init (hype: Hype) {
        self.init(recordType: HypeStrings.recordTypeKey)
        self.setValuesForKeys([
            HypeStrings.bodyKey : hype.body,
            HypeStrings.timeStampKey : hype.timeStamp
        ])
        
        
    }
    
}
