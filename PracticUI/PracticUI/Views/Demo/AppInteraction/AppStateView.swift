//
//  AppStateView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI
import Inject

struct AppStateView: View {
    
    @ObserveInjection var inject
    
    @Environment(\.scenePhase)  var scenePhase
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onChange(of: scenePhase, perform: { newValue in
                    if newValue == .active{
                        print("active")
                    }else if newValue == .background{
                        print("background")
                    }
                    else if newValue == .inactive{
                        print("inactive")
                    }
                })
        }
        .enableInjection()
    }
}

struct AppStateView_Previews: PreviewProvider {
    static var previews: some View {
        AppStateView()
    }
}
