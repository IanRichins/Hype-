//
//  HypeController.swift
//  Hype!
//
//  Created by Ian Richins on 5/10/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import Foundation
import CloudKit

class HypeController {
    
    static let sharedInstance = HypeController()
    
    var hypes: [Hype] = []
    
    // constant to access our stored publicCloudDatabase
    let publicDB = CKContainer.default().publicCloudDatabase
    
    //MARK: -CRUD
    
    func saveHype(with text: String, completion: @escaping (Bool) -> Void) {
        // initialize a hype object
        let newHype = Hype(body: text)
        //package hype into a CKRecord
        let hypeRecord = CKRecord(hype: newHype)
        // saving the hypeRecord to the cloud
        publicDB.save(hypeRecord) { (record, error) in
            // handling the error
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            // unwrapping the record that was saved
            guard let record = record,
                // ensuring we can initalize a hype from that record
                let saveHype = Hype(ckRecord: record)
                else { completion(false) ; return }
            print("Saved Hype successfully")
            // if we have success we add it to the source of truth array
            self.hypes.insert(saveHype, at: 0)
            completion(true)
        }
    }
    
    func fetchHype(completion: @escaping (Bool) -> Void) {
        // Step 3 initialize the predicate needed for the query
        let predicate = NSPredicate(value: true)
        // Step 2 initialize the query that is needed for the .perform method
        let query = CKQuery(recordType: HypeStrings.recordTypeKey, predicate: predicate)
        // Step 1 perform a query on the database
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            // handle the error
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            // unwrap the found records
            guard let records = records else { completion(false) ; return }
            print("fetched all hypes")
            // compact map through the found records to return an array of non nil results
            let fetchedHypes = records.compactMap { Hype(ckRecord: $0) }
            // Set the source of truth
            self.hypes = fetchedHypes
            completion(true)
                
            }
        }
    }
    

