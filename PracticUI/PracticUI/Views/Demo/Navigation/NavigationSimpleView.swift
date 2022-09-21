//
//  NavigationSimple.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/20.
//

import SwiftUI
import Inject

struct NavigationSimpleView: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        VStack{
            NavigationLink {
                NavigationSimpleView_1()
            } label: {
                Text("jump #1")
            }
        }
        .enableInjection()
    }
}




struct NavigationSimpleView_1: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        VStack{
             Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle("#1")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    //仅会显示第一个
//                    Button("btn2"){
//
//                    }
//                    Button("btn1"){
//
//                    }
                    
                    ToolbarItem(placement: .principal) {
                        Image(systemName: "location.circle")
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "trash")
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "star")
                    }
                    
                    //默认在右边
                    ToolbarItem(placement: .navigation) {
                        Image(systemName: "chevron.backward")
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Image(systemName: "chevron.forward")
                    }
                }
        }
        .enableInjection()
    }
}

