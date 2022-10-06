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
    
    @AppStorage("selectTab") var selectionTab: Tab = .explore
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            SplashPageView(isShow: $model.isShowSplashPage).zIndex(999)
            
            SideBarView(isAbleShow: $model.isAbleShowSidebar){
                AccountView()
            } content: {
                ZStack {
                    if selectionTab == .demo {
                        DemoView()
                    }
                    else if selectionTab == .explore{
                        ExploreView()
                    }
                    
                    TabItemView()
                        .offset(y: model.isShowCustomTabbar ? 0 : 200)
                        .zIndex(99)
                }
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $model.isShowLoginModal){
            LoginView()
        }
        .enableInjection()
    }
}
