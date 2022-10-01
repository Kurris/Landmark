//
//  TabItem.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/22.
//

import Foundation
import SwiftUI


struct TabItem: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    var tab: Tab
    
    static let `default`: [TabItem] = [
        TabItem(name: Tab.demo.description(), icon: "lasso.and.sparkles", tab: .demo),
        //TabItem(name: Tab.house.description(), icon: "house", tab: .house),
        TabItem(name: Tab.explore.description(), icon: "magnifyingglass", tab: .explore),
        //TabItem(name: Tab.account.description(), icon: "person", tab: .account),
    ]
}


enum Tab: Int {
    case demo  = 1
    case explore, account , house

    func description() -> String {
        switch self {
        case .house:
            return "主页"
        case .explore:
            return "搜索"
        case .account:
            return "我的"
        case .demo:
            return "Demo"
        }
    }
}

struct TabReferenceKey: PreferenceKey {
    typealias Value = [MyTextPreferenceData]
    
    static var defaultValue: [MyTextPreferenceData] = []
    
    static func reduce(value: inout [MyTextPreferenceData], nextValue: () -> [MyTextPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}
