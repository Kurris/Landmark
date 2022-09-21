//
//  DefaultTab.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/20.
//

import SwiftUI
import Inject

struct DefaultTab: View {
    
    @ObserveInjection var inject
    
    @State var selection = 0
    @EnvironmentObject var model : Model
    
    let titles = ["Demo"]
    
    
    var body: some View {
        NavigationView{
            TabView(selection: $selection){
                NavigationSimpleView()
                    .tabItem {
                      Image(systemName: "lasso.and.sparkles")
                        Text("Demo")
                    }
                    .tag(0)
            }
            .onAppear{
                withAnimation {
                    model.isShowCardDetail = true
                }
            }
            .navigationTitle(titles[selection])
            .onDisappear{
                withAnimation {
                    model.isShowCardDetail = false
                }
            }
        }
        .enableInjection()
    }
}

struct DefaultTab_Previews: PreviewProvider {
    static var previews: some View {
        DefaultTab()
    }
}
