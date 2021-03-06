//
//  FriendBook.swift
//  Cheap Shoppers
//
//  Created by Student on 10/19/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

extension UIViewController {
    
    static func alert(title:String, message:String){
        
        DispatchQueue.main.async {
            let topViewController = UIApplication.shared.keyWindow!.rootViewController!
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            ac.addAction(action)
            topViewController.present(ac, animated:true)
        }
    }
}

class Custodian {
    static var defaultContainer:CKContainer = CKContainer.default()
    static var publicDatabase:CKDatabase = defaultContainer.publicCloudDatabase
    static var privateDatabase:CKDatabase = defaultContainer.privateCloudDatabase
    static var anotherDatabase = CKContainer(identifier: "").publicCloudDatabase
}


class Friend : Equatable, CKRecordValueProtocol, Hashable {
    
    var record: CKRecord! // this is the only stored property, basically this class is a wrapper class for CKRecord
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ssn)
    }
    var ssn: Int {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["ssn"]!
        }
        set(ssn){
            record["ssn"] = ssn
        }
    }
    
    
    var firstName: String {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["firstName"]!
        }
        set(firstName){
            record["firstName"] = firstName
        }
    }
    
    var lastName: String {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["lastName"]!
        }
        set(lastName){
            record["lastName"] = lastName
        }
    }
    
    var phone: String {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["phone"]!
        }
        set(phone){
            record["phone"] = phone
        }
    }
    init(record:CKRecord){
        self.record = record
    }
    
    init(ssn:Int, firstName:String, lastName:String, phone:String){
        let friendRecordId = CKRecord.ID(recordName: "\(ssn)")                    // 1. create a record ID
        self.record = CKRecord(recordType: "Friend", recordID: friendRecordId)  // 2. create a record using that record ID
        self.record["ssn"] = ssn
        self.record["lastName"] = lastName
        self.record["firstName"] = firstName
        self.record["phone"] = phone
        self.ssn = ssn
        self.lastName = lastName
        self.firstName = firstName
        self.phone = phone
    }
    
    // Two teachers are deemed equal if they have the same ssn
    static func==(lhs:Friend,rhs:Friend)->Bool {
        return lhs.ssn == rhs.ssn
    }
}

class FriendBook {
    private var friends:[Friend] = []
    
    var numFriends:Int{
        return friends.count
    }
    
    private static var _shared:FriendBook!
    
    static var shared:FriendBook{
        if _shared == nil{
            _shared = FriendBook()
        }
        return _shared
    }
    
    subscript(i:Int)-> Friend{
        return friends[i]
    }
    
    /*func add(friend:Friend)throws{
        
        friends.append(friend)
        friends.sort { (friendA, friendB) in return friendA.lastName < friendB.lastName }
    }*/
    
    private init(){
        //populateCloudKitDatabase()
    }
    
    func fetchAllFriends(){
        
        let query = CKQuery(recordType: "Friend", predicate: NSPredicate(value:true)) // this gets *all * teachers
        Custodian.privateDatabase.perform(query, inZoneWith: nil){
            (friendRecords, error) in
            if let error = error {
                //self.alert(title: "Disaster while fetching all teachers:", message: "\(error)")
                UIViewController.alert(title: "Disaster while fetching all teachers", message:"\(error)")
            } else {
                FriendBook.shared.friends = []
                for friendRecord in friendRecords! {          // note the studentRecord -> student
                    let friend = Friend(record: friendRecord)
                    FriendBook.shared.friends.append(friend)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"All Friends Fetched"), object: nil)
            }
        }
    }
    
    
    /// Adds a teacher to CloudKit *and* locally
    ///
    /// - Parameter teacher: the teacher to add to the database
    func add(friend:Friend){
        
        Custodian.privateDatabase.save(friend.record){
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while adding a teacher", message:"\(error)")
            } else {
                self.friends.append(friend)
                UIViewController.alert(title:"Successfully saved friend", message:"") //don't save it locally, just in iCloud, because of the difficulties of managing the n side of a 1:n relationship
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Added New Friend"), object: friend)
                    UIViewController.alert(title: "Added New Friend", message:"")
                }
            }
            
        }
        
    }
    
    func deleteFriend(friend:Friend){
        
        if let index = FriendBook.shared.friends.firstIndex(of: friend) {
            FriendBook.shared.friends.remove(at: index)
        }
        Custodian.privateDatabase.delete(withRecordID: friend.record.recordID){
            (record, error) in
            if let error = error {
                UIViewController.alert(title: "Something has gone wrong while deleting a teacher", message:"\(error)")
            } else { // deleted from CloudKit, now let's delete our local version
                UIViewController.alert(title: "Successfully deleted friend", message: "")
            }
            
        }
    }
    
    func populateCloudKitDatabase(){
        
        //var friendsBook:[Friend]
        
        friends = [Friend(ssn: 123456777, firstName: "Ben", lastName: "Brown", phone: "5151111111")
        ]
        
        
        for friend in friends {
            
            Custodian.privateDatabase.save(friend.record){             // 4. save the record (after having gotten the container, and container.publicCloudDatabase
                
                (record, error) in                                                      // handle things going wrong
                if let error = error {
                    UIViewController.alert(title: "Disaster while saving friends", message:"\(error)")
                } else {
                    UIViewController.alert(title:"Success, saved friend", message:"")
                    
                    // having saved the teacher, now save their students
                    
                }
            }
            
            
        }
        
        
    }
    
    
}

enum FriendError:Error{
    case FriendNotFound
}
