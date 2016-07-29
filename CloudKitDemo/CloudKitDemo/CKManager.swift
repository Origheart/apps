//
//  CKManager.swift
//  CloudKitDemo
//
//  Created by 刘康 on 16/7/28.
//  Copyright © 2016年 刘康. All rights reserved.
//

import Foundation
import CloudKit

let container = CKContainer(identifier: icloudIdentifier())
let publicDB = container.publicCloudDatabase
let privateDB = container.privateCloudDatabase

func saveNewRecord(diary: Diary) {
    
    let newDiary = CKRecord(recordType: "Diary")
    debugPrint("Add New Diary To iCloud")
    updateRecord(diary, record: newDiary)
}

// 增
func updateRecord(diary: Diary, record: CKRecord) {
    
    record.setObject(diary.content, forKey: "Content")
    
    record.setObject(diary.created_at, forKey: "Created_at")
    
    if let location = diary.location {
        record.setObject(location, forKey: "Location")
    }
    
    if let title = diary.title {
        record.setObject(title, forKey: "Title")
    }
    
    record.setObject(diary.id, forKey: "id")
    
    privateDB.saveRecord(record, completionHandler: { (newDiary, error) -> Void in
        
        debugPrint("Diary Updated")
        
        if let error = error {
            debugPrint("error \(error.description)")
        }
        
    })
}

func fetchCloudRecordWithID(recordID: String , complete: (CKRecord?) -> Void) {
    
    let predicate = NSPredicate(format: "id == %@", recordID)
    
    let query = CKQuery(recordType: "Diary",
                        predicate: predicate )
    
    privateDB.performQuery(query, inZoneWithID: nil) {
        results, error in
        if let results = results, record = results.first{
            complete(record)
        } else {
            complete(nil)
        }
    }
}

// 删
func deleteCloudRecord(record: CKRecord) {
    privateDB.deleteRecordWithID(record.recordID) { (recordID, error) -> Void in
        print("Delete \(recordID?.recordName) \(error?.description)")
    }
}

// 查
func fetchCloudRecordWithTitle(title: String , complete: ([CKRecord]?) -> Void) {
    
    let predicate = NSPredicate(format: "Title == %@", title)
    
    let query = CKQuery(recordType: "Diary",
                        predicate: predicate )
    
    privateDB.performQuery(query, inZoneWithID: nil) {
        results, error in
        if let results = results {
            complete(results)
        } else {
            complete(nil)
        }
    }
}

// 查
func fetchCloudRecords(complete: ([CKRecord]?) -> Void) {
    
    let predicate = NSPredicate(value: true)
    
    let query = CKQuery(recordType: "Diary",
                        predicate: predicate )
    
    let queryOpration = CKQueryOperation(query: query)
    
    queryOpration.resultsLimit = 20
    
    queryOpration.qualityOfService = NSQualityOfService.UserInteractive
    
    var results = [CKRecord]()
    
    let recordFetchedBlock = { (record: CKRecord) in
        results.append(record)
    }
    
    var queryCompleteBlockSelf = { (cursor: CKQueryCursor?, error: NSError?) in }
    
    let queryCompleteBlock = { (cursor: CKQueryCursor?, error: NSError?) in
        if let cursor = cursor {
            let queryMoreOpration = CKQueryOperation(cursor: cursor)
            queryMoreOpration.queryCompletionBlock = queryCompleteBlockSelf
            queryMoreOpration.recordFetchedBlock = recordFetchedBlock
            privateDB.addOperation(queryMoreOpration)
        } else {
            debugPrint("query error: \(error)")
            complete(results)
        }
    }
    
    queryCompleteBlockSelf = queryCompleteBlock
    
    queryOpration.recordFetchedBlock = recordFetchedBlock
    
    queryOpration.queryCompletionBlock = queryCompleteBlockSelf
    
    privateDB.addOperation(queryOpration)
    
}