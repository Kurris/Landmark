//
//  Profile.swift
//  PracticeApp
//
//  Created by 李国扬 on 2022/8/19.
//

import Foundation

struct Profile{
    var username : String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()
    
    static let `default` = Profile(username: "ligy")
    
    enum Season: String,CaseIterable,Identifiable {
        case spring = "🌹"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "⛄️"
        
        var id : String  { rawValue }
    }
}
