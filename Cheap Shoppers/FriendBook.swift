//
//  FriendBook.swift
//  Cheap Shoppers
//
//  Created by Student on 10/19/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import Foundation

struct Friend{
    var firstName:String
    var lastName:String
    var phone:String
}

class FriendBook {
    private var _friends:[Friend]
    
    var friends:[Friend]{
        return _friends
    }
    
    var numFriends:Int{
        return _friends.count
    }
    
    private static var _shared:FriendBook!
    
    static var shared:FriendBook{
        if _shared == nil{
            _shared = FriendBook()
        }
        return _shared
    }
    
    subscript(i:Int)-> Friend{
        return _friends[i]
    }
    
    func add(friend:Friend)throws{
        
        _friends.append(friend)
        _friends.sort { (friendA, friendB) in return friendA.lastName < friendB.lastName }
    }
    
    private init(){
        _friends = [Friend(firstName: "Clinton", lastName: "Davelaar", phone: "0123456789"),
                    Friend(firstName: "Mike", lastName: "Burnes", phone: "9876543210")]
    }
    
    
}

enum FriendError:Error{
    case FriendNotFound
}
