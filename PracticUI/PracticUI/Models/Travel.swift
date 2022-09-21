//
//  Travel.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/24.
//

import Foundation


struct Travel: Identifiable {
    var id = UUID()
    var auther: String
    var title: String
    var subTitle: String

    var contentTitle: String
    var content: String

    var backgroundImage: String


    static var `default`: [Travel] = [
        Travel(auther: "ligy", title: "凤起花园", subTitle: "杭州之旅:苦逼开始", contentTitle: "spring", content: "春天", backgroundImage: "bg-0"),
        Travel(auther: "ligy", title: "益乐新村", subTitle: "杭州之旅:慢慢习惯", contentTitle: "summer", content: "夏天", backgroundImage: "bg-2"),
        Travel(auther: "ligy", title: "银都大厦", subTitle: "杭州之旅:奋斗刚开始", contentTitle: "autumn", content: "秋天", backgroundImage: "bg-3")
    ]
}
