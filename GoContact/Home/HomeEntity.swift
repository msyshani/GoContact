//
//  HomeEntity.swift
//  GoContact
//
//  Created by Mahendra Yadav on 18/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

struct ContactEntity:Codable{
    var id:Int?
    var firstName:String = ""
    var lastName:String = ""
    var profilePicUrl:String?
    var isFavorite:Bool
    var url:String?
    var phoneNumber:String?
    var email:String?
    
    init(dict:[String:Any]) {
        self.isFavorite = false
    }
    
    enum CodingKeys :String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePicUrl = "profile_pic"
        case isFavorite = "favorite"
        case url
        case phoneNumber = "phone_number"
        case email
    }
    
}
