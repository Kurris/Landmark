//
//  CheckToggleStyleView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct CheckToggleStyleView: View {
   
    @ObserveInjection var inject
    
    @State private var isOn = false
    
    var body: some View {
        VStack{
            Toggle(isOn:$isOn) {
                Text("checkbox")
            }
            .toggleStyle(CheckToggleStyle())
        }
        .enableInjection()
    }
}
