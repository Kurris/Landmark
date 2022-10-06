//
//  Model.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/30.
//

import Foundation
import Combine

class Model: ObservableObject {
    
    @Published var isShowCardDetail = false
    @Published var isShowAccountSheet = false
    @Published var isShowSearch = false
    @Published var cardSelectedId : UUID = UUID()
    
    @Published var isShowCustomTabbar = true
    @Published var isAbleShowSidebar = true
    @Published var isShowSplashPage = true
}
