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

class ShopItem : Equatable, CKRecordValueProtocol, Hashable {
    
    var record: CKRecord! // this is the only stored property, basically this class is a wrapper class for CKRecord
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    var id: Int {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["id"]!
        }
        set(id){
            record["id"] = id
        }
    }
    
    
    var price: Double {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["price"]!
        }
        set(price){
            record["price"] = price
        }
    }
    var itemName: String {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["itemName"]!
        }
        set(itemName){
            record["itemName"] = itemName
        }
    }
    var storeName: String {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["storeName"]!
        }
        set(storeName){
            record["storeName"] = storeName
        }
    }
    
    init(record:CKRecord){
        self.record = record
        
    }
    
    init(id:Int, price:Double,itemName:String, storeName:String){
        let itemRecordId = CKRecord.ID(recordName: "\(id)")                    // 1. create a record ID
        self.record = CKRecord(recordType: "ShopItem", recordID: itemRecordId)  // 2. create a record using that record ID
        self.record["id"] = id
        self.record["price"] = price
        self.record["itemName"] = itemName
        self.record["storeName"] = storeName
        self.id = id
        self.price = price
        self.storeName = storeName
        self.itemName = itemName
    }
    
    // Two teachers are deemed equal if they have the same ssn
    static func==(lhs:ShopItem,rhs:ShopItem)->Bool {
        return lhs.id == rhs.id
    }
}

class ItemArchive {
    private var items:[ShopItem] = []
    
    var numItem:Int{
        return items.count
    }
    
    private static var _shared:ItemArchive!
    
    static var shared:ItemArchive{
        if _shared == nil{
            _shared = ItemArchive()
        }
        return _shared
    }
    
    subscript(i:Int)-> ShopItem{
        return items[i]
    }
    
    /*func add(friend:Friend)throws{
     
     friends.append(friend)
     friends.sort { (friendA, friendB) in return friendA.lastName < friendB.lastName }
     }*/
    
    private init(){
        //populateCloudKitDatabase()
    }
    
    func fetchAllItems(){
        
        let query = CKQuery(recordType: "ShopItem", predicate: NSPredicate(value:true)) // this gets *all * teachers
        Custodian.privateDatabase.perform(query, inZoneWith: nil){
            (itemRecords, error) in
            if let error = error {
                //self.alert(title: "Disaster while fetching all teachers:", message: "\(error)")
                UIViewController.alert(title: "Disaster while fetching all items", message:"\(error)")
            } else {
                ItemArchive.shared.items = []
                for itemRecord in itemRecords! {          // note the studentRecord -> student
                    let item = ShopItem(record: itemRecord)
                    ItemArchive.shared.items.append(item)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"All Items Fetched"), object: nil)
            }
        }
    }
    
    
    /// Adds a teacher to CloudKit *and* locally
    ///
    /// - Parameter teacher: the teacher to add to the database
    func add(item:ShopItem){
        Custodian.privateDatabase.save(item.record){
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while adding a item", message:"\(error)")
            } else {
                self.items.append(item)
                UIViewController.alert(title:"Successfully saved item", message:"") //don't save it locally, just in iCloud, because of the difficulties of managing the n side of a 1:n relationship
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Added New Item"), object: item)
                    UIViewController.alert(title: "Added New Item", message:"")
                }
            }
            
        }
        
    }
    
    func populateCloudKitDatabase(){
        
        //var friendsBook:[Friend]
        
        items = [ShopItem(id: 1, price: 2.3, itemName: "Tomato", storeName: "Walmart"),
                 ShopItem(id: 2, price: 1.3, itemName: "Potato", storeName: "Hyvee"),
                 ShopItem(id: 3, price: 4.3, itemName: "Cauliflower", storeName: "Walmart"),
                 ShopItem(id: 4, price: 6.0, itemName: "Milk", storeName: "Walmart"),
                 ShopItem(id: 5, price: 3.0, itemName: "Bread", storeName: "Walmart"),
                 ShopItem(id: 6, price: 8.0, itemName: "Coke", storeName: "Hyvee"),
                 
        ]
        
        
        for item in items {
            
            Custodian.privateDatabase.save(item.record){             // 4. save the record (after having gotten the container, and container.publicCloudDatabase
                
                (record, error) in                                                      // handle things going wrong
                if let error = error {
                    UIViewController.alert(title: "Disaster while saving items", message:"\(error)")
                } else {
                    UIViewController.alert(title:"Success, saved item", message:"")
                    
                    // having saved the teacher, now save their students
                    
                }
            }
            
            
        }
        
        
    }
    
    
}

enum ShopItemError:Error{
    case ItemNotFound
}
