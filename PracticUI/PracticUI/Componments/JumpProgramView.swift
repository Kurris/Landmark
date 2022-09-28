//
//  JumpProgramView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/28.
//

import SwiftUI
import Inject

struct JumpProgramView<Label:View, Destination:View> : View {
    
    @ObserveInjection var inject
    
    @EnvironmentObject var model : Model
    
    let linkLabel: Label
    let linkDestination: Destination
    
    @Binding var isActive : Bool
    
    init(isActive: Binding<Bool> , @ViewBuilder destination: ()->Destination, @ViewBuilder label: ()->Label) {
        _isActive = isActive
        linkLabel = label()
        linkDestination = destination()
    }
    
    var body: some View {
        NavigationLink(isActive: $isActive, destination: {
            linkDestination
                .onAppear {
                    model.isAbleShowSidebar = false
                }
                .onDisappear {
                    model.isAbleShowSidebar = true
                }
        }, label: {
            linkLabel
        })
            .enableInjection()
    }
}

