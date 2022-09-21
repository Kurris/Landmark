//
//  DefaultBadgeView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct DefaultBadgeView: View {
    
    @ObserveInjection var inject
    
    @EnvironmentObject var model : Model
    
    var body: some View {
        VStack{
            TabView{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .tabItem{
                        Text("A")
                    }
                    .badge(5)
            }
        }
        .onAppear(perform: {
            model.isShowCardDetail=true
        })
        .onDisappear(perform: {
            model.isShowCardDetail=false
        })
        .enableInjection()
    }
}

struct DefaultBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultBadgeView()
    }
}
