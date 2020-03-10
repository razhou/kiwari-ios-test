//
//  Constants.swift
//  Chat
//
//  Created by Jelajah Data Semesta on 10/03/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
    
    struct UserOne {
        static let name = "Jarjit Singh"
        static let avatar = "https://api.adorable.io/avatars/160/jarjit@mail.com.png"
        static let email = "jarjit@mail.com"
        static let password = "123456"
        static let senderId = "123456"
    }
    
    struct UserTwo {
        
        static let name = "Ismail bin Mail"
        static let avatar = "https://api.adorable.io/avatars/160/ismail@mail.com.png"
        static let email = "ismail@mail.com"
        static let password = "123456"
        static let senderId = "654321"
    }
}
