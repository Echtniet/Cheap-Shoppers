//
//  myList.swift
//  Cheap Shoppers
//
//  Created by Rohith Bharadwaj on 24/10/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class myList  : Equatable, CKRecordValueProtocol, Hashable {
    
    var record: CKRecord!
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Int {
        get{
            return record["id"]!
        }
        set(id){
            record["id"] = id
        }
    }
    
    var listName: String {                      // hides the use of a CKRecord ... pretty slick, if I do say so myself
        get {
            return record["listName"]!
        }
        set(listName){
            record["listName"] = listName
        }
    }
    
    init(record:CKRecord){
        self.record = record
    }
    
    init(id: Int, listName: String){
        let listRecordId = CKRecord.ID(recordName:"\(id)")
        self.record = CKRecord(recordType: "Lists", recordID: listRecordId)
        self.record["id"] = id
        self.record["listName"] = listName
        self.id = id
        self.listName = listName
    }
    
    static func == (lhs: myList, rhs: myList) -> Bool{
        return lhs.id == rhs.id
    }
}

class Items : Equatable{
    
    var record: CKRecord!
    
    var itemId: Int {
        get{
            return record["itemId"]!
        }
        set(id){
            record["itemId"] = itemId
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

    var cheapProducts: CKRecord.Reference!  {   // so we can point to records in CloudKit
        get {
            return record["cheapProducts"]
            
        }
        set(cheapProducts) {
            record["cheapProducts"] = cheapProducts
        }
        
    }
    
    init(record:CKRecord){
        self.record = record
    }
    
    init(itemId: Int, itemName: String){
        let itemRecordId = CKRecord.ID(recordName:"\(itemId)")
        self.record = CKRecord(recordType: "items", recordID: itemRecordId)
        self.record["itemId"] = itemId
        self.record["itemName"] = itemName
        self.itemId = itemId
        self.itemName = itemName
    }
    
    static func == (lhs: Items, rhs: Items) -> Bool{
        return lhs.itemId == rhs.itemId
    }
    
    //
    private var items:[myList] = []
    private static var _shared:Items!
    
    var numItem:Int{
        return items.count
    }
    
    static var shared:Items {
        if _shared == nil {
            _shared = Items()
        }
        return _shared
    }
    
    subscript(i:Int) -> myList {
        return items[i]
    }
    
    private init(){
        populateCloudKitDatabase()
    }
    
    func fetchAllItems(){
        
        let query = CKQuery(recordType: "Items", predicate: NSPredicate(value:true)) // this gets *all * teachers
        Custodian.privateDatabase.perform(query, inZoneWith: nil){
            (listsRecords, error) in
            if let error = error {
                //self.alert(title: "Disaster while fetching all teachers:", message: "\(error)")
                UIViewController.alert(title: "Disaster while fetching all Items", message:"\(error)")
            } else {
                Items.shared.items = []
                for listRecord in listsRecords! {          // note the studentRecord -> student
                    let item = myList(record: listRecord)
                    Items.shared.items.append(item)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"All Items Fetched"), object: nil)
            }
        }
    }
    
    func add(item:myList){
        Custodian.privateDatabase.save(item.record){
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while adding a teacher", message:"\(error)")
            }else {
                self.items.append(item)
                UIViewController.alert(title:"Successfully saved Item", message:"") //don't save it locally, just in iCloud, because of the difficulties of managing the n side of a 1:n relationship
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Added New Item"), object: item)
                    UIViewController.alert(title: "Added New Item", message:"")
                }
            }
        }
    }
    
    func populateCloudKitDatabase(){
       
        items = [myList(id: 1, listName: "Item 1"), myList(id: 2, listName: "Item 2")]
        for item in items {
            Custodian.privateDatabase.save(item.record){
                (record, error) in
                if let error = error {
                    UIViewController.alert(title: "Disaster while saving lists", message:"\(error)")
                } else {
                    UIViewController.alert(title:"Success, saved lists", message:"")
                }
            }
        }
    }
}


class cheapProducts {
    private var lists:[myList] = []
    
    private static var _shared:cheapProducts!
    
    var numList:Int{
        return lists.count
    }
    
    static var shared:cheapProducts {
        if _shared == nil {
            _shared = cheapProducts()
        }
        return _shared
    }
    
    subscript(i:Int) -> myList {
        return lists[i]
    }
    
    
    private init(){
        //populateCloudKitDatabase()
    }
    // returns the artist at ith location
    
    func fetchAllLists(){
        
        let query = CKQuery(recordType: "Lists", predicate: NSPredicate(value:true)) // this gets *all * teachers
        Custodian.privateDatabase.perform(query, inZoneWith: nil){
            (listsRecords, error) in
            if let error = error {
                //self.alert(title: "Disaster while fetching all teachers:", message: "\(error)")
                UIViewController.alert(title: "Disaster while fetching all teachers", message:"\(error)")
            } else {
                cheapProducts.shared.lists = []
                for listRecord in listsRecords! {          // note the studentRecord -> student
                    let list = myList(record: listRecord)
                    cheapProducts.shared.lists.append(list)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"All Lists Fetched"), object: nil)
            }
        }
    }
    
    func add(list:myList){
        Custodian.privateDatabase.save(list.record){
            (record, error) in
            if let error = error {
                UIViewController.alert(title:"Something has gone wrong while adding a teacher", message:"\(error)")
            }else {
                self.lists.append(list)
                UIViewController.alert(title:"Successfully saved list", message:"") //don't save it locally, just in iCloud, because of the difficulties of managing the n side of a 1:n relationship
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("Added New List"), object: list)
                    UIViewController.alert(title: "Added New List", message:"")
                }
            }
        }
    }
    
    func populateCloudKitDatabase(){
       
        lists = [myList(id: 1, listName: "List 1"), myList(id: 2, listName: "List 2")]
        for list in lists {
            Custodian.privateDatabase.save(list.record){
                (record, error) in
                if let error = error {
                    UIViewController.alert(title: "Disaster while saving lists", message:"\(error)")
                } else {
                    UIViewController.alert(title:"Success, saved lists", message:"")
                }
            }
        }
    }
    
}
enum ListError:Error{
    case ListNotFound
}
