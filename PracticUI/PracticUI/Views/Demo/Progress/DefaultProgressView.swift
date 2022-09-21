//
//  DefaultProgressView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/16.
//

import SwiftUI
import Inject

struct DefaultProgressView: View {
    
    @ObserveInjection var inject
    @State private var current:Double = 20.0
    
    var body: some View {
        VStack{
            
            ProgressView()
                .padding()
            
            ProgressView("进度:\(Int(current))%",value: current, total: 100)
                .progressViewStyle(.linear)
                .padding()
            
            
            Button {
                current+=1
            } label: {
               Text("increament")
            }
        }
        .padding()
        .enableInjection()
    }
}

struct DefaultProgressView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultProgressView()
    }
}
