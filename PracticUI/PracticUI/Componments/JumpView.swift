//
//  JumpView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/27.
//

import SwiftUI
import Inject

struct JumpView<Label:View, Destination:View> : View {
    
    @ObserveInjection var inject
    
    @EnvironmentObject var model : Model
    
    let linkLabel: Label
    let linkDestination: Destination
    
    init(@ViewBuilder destination: ()->Destination, @ViewBuilder label: ()->Label) {
        linkLabel = label()
        linkDestination = destination()
    }
    
    var body: some View {
        NavigationLink {
            linkDestination
                .onAppear {
                    withAnimation {
                        model.isAbleShowSidebar = false
                        model.isShowCustomTabbar = false
                    }
                }
                .onDisappear {
                    withAnimation {
                        model.isAbleShowSidebar = true
                        model.isShowCustomTabbar = true
                    }
                }
        } label: {
            linkLabel
        }
        .enableInjection()
    }
}
