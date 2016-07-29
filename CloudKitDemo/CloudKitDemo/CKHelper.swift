//
//  CKHelper.swift
//  CloudKitDemo
//
//  Created by 刘康 on 16/7/28.
//  Copyright © 2016年 刘康. All rights reserved.
//

import Foundation
import CloudKit

func icloudIdentifier() -> String {
    let teamID = "iCloud."
    let bundleID = NSBundle.mainBundle().bundleIdentifier!
    let cloudRoot = "\(teamID)\(bundleID).sync"
    
    return cloudRoot
}

func recordsToDiary(records: [CKRecord]?) -> [Diary]? {
    var diaries: [Diary] = []
    guard let records = records else { return nil }
    for record in records {
        let diary = Diary()
        if let diaryID = record.objectForKey("id") as? String,
            title = record.objectForKey("Title") as? String,
            location = record.objectForKey("Location") as? String,
            createdAt = record.objectForKey("Created_at") as? NSDate,
            content = record.objectForKey("Content") as? String {
            
            diary.content = content
            diary.created_at = createdAt
            diary.location = location
            diary.title = title
            diary.id = diaryID
            
        }
        diaries.append(diary)
    }
    return diaries
}

func randomStringWithLength (len : Int) -> NSString {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    let randomString : NSMutableString = NSMutableString(capacity: len)
    
    for _ in 0 ..< len {
        let length = UInt32 (letters.length)
        let rand = arc4random_uniform(length)
        randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
    }
    
    return randomString
}

func diaryToRecord(diary: Diary) -> CKRecord {
    let record = CKRecord(recordType: "Diary")
    record.setObject(diary.content, forKey: "Content")
    
    record.setObject(diary.created_at, forKey: "Created_at")
    
    if let location = diary.location {
        record.setObject(location, forKey: "Location")
    }
    
    if let title = diary.title {
        record.setObject(title, forKey: "Title")
    }
    
    record.setObject(diary.id, forKey: "id")
    
    return record
}
