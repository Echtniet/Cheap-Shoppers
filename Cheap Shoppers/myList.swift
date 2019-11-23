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
    
    var id: String {
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
    
    init(id: String, listName: String){
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

class ListItem : Equatable{
    
    var record: CKRecord!
    
    var itemId: String {
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
    
    var list: CKRecord.Reference!  {   // so we can point to records in CloudKit
        get {
            return record["list"]
            
        }
        set(list) {
            record["list"] = list
        }
        
    }
    
    init(record:CKRecord){
        self.record = record
    }
    
    init(itemId: String, itemName: String, list:CKRecord.Reference?){
        let itemRecordId = CKRecord.ID(recordName:"\(itemId)")
        self.record = CKRecord(recordType: "ListItem", recordID: itemRecordId)
        self.record["itemId"] = itemId
        self.record["itemName"] = itemName
        self.itemId = itemId
        self.itemName = itemName
        self.list = list
    }
    
    static func == (lhs: ListItem, rhs: ListItem) -> Bool{
        return lhs.itemId == rhs.itemId
    }
}


class cheapProducts {
    
    
    private static var _shared:cheapProducts!
    
    private var lists:[myList] = []
    public var items:[ListItem] = []
    
    var numList:Int{
        return lists.count
    }
    
    var numItems:Int{
        return items.count
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
        
    }
    // returns the artist at ith location
    
    func fetchAllLists(){
        
        let query = CKQuery(recordType: "Lists", predicate: NSPredicate(value:true)) // this gets *all * teachers
        Custodian.privateDatabase.perform(query, inZoneWith: nil){
            (listsRecords, error) in
            if let error = error {
                //self.alert(title: "Disaster while fetching all teachers:", message: "\(error)")
                UIViewController.alert(title: "Disaster while fetching all lists", message:"\(error)")
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
    
    func fetchAllItems(){
        
        let query = CKQuery(recordType: "ListItem", predicate: NSPredicate(value:true))
        Custodian.privateDatabase.perform(query, inZoneWith: nil){
            (itemsRecords, error) in
            if let error = error {
                //self.alert(title: "Disaster while fetching all teachers:", message: "\(error)")
                UIViewController.alert(title: "Disaster while fetching all items", message:"\(error)")
            } else {
                
                for itemRecord in itemsRecords! {          // note the studentRecord -> student
                    let item = ListItem(record: itemRecord)
                    cheapProducts.shared.items.append(item)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"All Items Fetched"), object: nil)
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
    
    func add(listItem:ListItem){
        Custodian.privateDatabase.save(listItem.record){
            (record, error) in
            if let error = error{
                UIViewController.alert(title: "Something has gone wrong while adding item", message: "\(error)")
            }else{
                UIViewController.alert(title: "Successfully saved item", message: "")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Added new item for list"), object: listItem)
                    UIViewController.alert(title: "Added New Item", message: "")
                }
            }
        }
    }
    
    func deleteList(list:myList){
        
        if let index = cheapProducts.shared.lists.firstIndex(of: list) {
            cheapProducts.shared.lists.remove(at: index)
        }
        Custodian.privateDatabase.delete(withRecordID: list.record.recordID){
            (record, error) in
            if let error = error {
                UIViewController.alert(title: "Something has gone wrong while deleting a list", message:"\(error)")
            } else { // deleted from CloudKit, now let's delete our local version
                UIViewController.alert(title: "Successfully deleted list", message: "")
            }
            
        }
    }
    
    /// Deletes a student
    ///
    /// - Parameter student: student to delete
    func deleteListItem(listItem:ListItem){
        
        Custodian.privateDatabase.delete(withRecordID: listItem.record.recordID){
            (record, error) in
            if let error = error {
                UIViewController.alert(title: "Something has gone wrong while deleting a list item", message:"\(error)")
            } else { // deleted from CloudKit, now let's delete our local version
                UIViewController.alert(title: "Successfully deleted list item", message: "")
            }
        }
    }
    
    func populateCloudKitDatabase(){
        
        var listAndItems:[myList:[ListItem]]
        
        lists = [myList(id: "L1", listName: "List 1"), myList(id: "L2", listName: "List 2")]
        
        items = [ListItem(itemId: "LI1", itemName: "Mayo", list: nil),
                 ListItem(itemId: "LI2", itemName: "Bread", list: nil),
                 ListItem(itemId: "LI3", itemName: "Mustard", list: nil),
                 ListItem(itemId: "LI4", itemName: "Honey", list: nil),
                 ListItem(itemId: "LI5", itemName: "Tea", list: nil),
                 ListItem(itemId: "LI6", itemName: "Mug", list: nil),
        ]
        
        listAndItems = [lists[0]:[items[0], items[1], items[2]],
                        lists[1]:[items[3], items[4], items[5]]]
        
        for(list, items) in listAndItems{
            Custodian.privateDatabase.save(list.record){
                (record, error) in
                if let error = error {
                    UIViewController.alert(title: "Disaster while saving list", message: "\(error)")
                }else{
                    UIViewController.alert(title: "Success, saved list", message: "")
                    
                    for item in items {
                        item.list = CKRecord.Reference(recordID: list.record.recordID, action: .deleteSelf)
                        
                        Custodian.privateDatabase.save(item.record){
                            (record, error) in
                            if let error = error {
                                UIViewController.alert(title: "Disaster while saving items", message: "\(error)")
                            }else{
                                UIViewController.alert(title: "Success, item saved", message: "")
                            }
                        }
                    }
                }
            }
        }
    }
    
}
enum ListError:Error{
    case ListNotFound
}
