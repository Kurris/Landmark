//
//  UserInfo.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/6.
//

import Foundation

struct UserInfo : Decodable {
    var sub: String
    var name : String
    var website: String
    var profile: String
    var given_name: String
    var family_name: String
    var picture : String
}
