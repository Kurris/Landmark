//
//  ToggleView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/20.
//

import SwiftUI
import Inject

struct ToggleView: View {
    
    @ObserveInjection var inject
    
    @State var isOn = false
    
    var body: some View {
        VStack{
            Toggle("toggle", isOn: $isOn.animation(.spring()))
                .toggleStyle(.checkBox)
            
            Toggle("toggle", isOn: $isOn.animation(.spring()))
                .toggleStyle(.button)
            
            Toggle("toggle", isOn: $isOn.animation(.spring()))
                .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
        .enableInjection()
    }
}
