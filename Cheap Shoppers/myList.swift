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

class myList{
    var listName: String
    init(listName: String){
        self.listName = listName
    }
}

class cheapProducts {
    
    private static var _shared:cheapProducts!
    
    private var mylist:[myList] = [
        myList(listName: "Apparels"),
        myList(listName: "Footwear"),
        myList(listName: "Electronics"),
        myList(listName: "AutoParts")
    ]
    
    
    static var shared:cheapProducts {
        if _shared == nil {
            _shared = cheapProducts()
        }
        return _shared
    }
    
    private init(){
    }
    // returns the artist at ith location
    
    subscript(i:Int) -> myList {
        return mylist[i]
    }
    
    // returns the count of artist
    func numMyList() -> Int{
        return mylist.count
    }
    // adds the artist
    
    func addMyList(newlist:myList){
        mylist.append(newlist)
    
       // mylist.append(mylist)
        
    }
    // deletes the artist
    func deleteMyList(at index:Int){
        mylist.remove(at:index)
    }
    
    
}
