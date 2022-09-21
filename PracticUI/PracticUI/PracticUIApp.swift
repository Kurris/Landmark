//
//  PracticUIApp.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/21.
//

import SwiftUI
import Inject

@main
struct PracticUIApp: App {
    @ObserveInjection var inject
    //确保应用程序只会创建一次 model
    @StateObject var model  = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Model())
                .enableInjection()
        }
    }
}
