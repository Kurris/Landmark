//
//  ContentView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/21.
//

import SwiftUI
import Inject

struct ContentView: View {
    
    @ObserveInjection var inject
    @EnvironmentObject var model: Model
    
    @AppStorage("selectTab") var selectionTab: Tab = .demo
    
    var demoView = DemoView()
    var homeView  = HomeView()
    var exploreView = ExploreView()
    var accountView = AccountView()
 
    var body: some View {
        
        SideBarView{
            Color.white
        } content: {
            ZStack(alignment: .bottom) {
                if selectionTab == .demo {
                    demoView
                }
                else if selectionTab == .house{
                    homeView
                }else if selectionTab == .explore{
                    exploreView
                }else{
                    accountView
                }
                
                TabItemView()
                    .offset(y: model.isShowCardDetail ? 200 : 0)
                    .zIndex(99)
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 70)
            }
         
        }
        .edgesIgnoringSafeArea(.all)
        .enableInjection()
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
