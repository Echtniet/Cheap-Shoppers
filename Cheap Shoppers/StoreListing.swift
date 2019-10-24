//
//  StoreListing.swift
//  Cheap Shoppers
//
//  Created by Student on 10/23/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import Foundation

struct Item{
    var itemName:String
    var price:Double
    var storeName:String
}

class StoreListing {
    private var _items:[String : Item]
    private var _numItems = 0
    
    var items:[String : Item]{
        return _items
    }
    
    var numItems:Int{
        return _numItems
    }
    
    private static var _shared:StoreListing!
    
    static var shared:StoreListing{
        if _shared == nil{
            _shared = StoreListing()
        }
        return _shared
    }
    
    subscript(itemName:String) -> Item {
        let item = _items[itemName]!
        return item
    }
    
    func add(item:Item)throws{
        _items[item.itemName] = item
        _numItems += 1
    }
    
    private init(){
        _items = [String:Item]()
        _items["Mayo"] = Item(itemName: "Mayo", price: 3.20, storeName: "Walmart")
        _items["Mayo"] = Item(itemName: "Mayo", price: 2.95, storeName: "HyVee")
    }
    
    
}

enum ItemError:Error{
    case ItemNotFound
}
