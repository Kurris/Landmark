//
//  SliderView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/20.
//

import SwiftUI
import Inject

struct SliderView: View {
    
    @ObserveInjection var inject
    
    @State var value = 0.0
    
    var body: some View {
        VStack{
            Slider(value: $value, in: 0...1)
            
            Slider(value: $value, in: 0...1)
                .tint(.orange)
        }
        .padding()
        .enableInjection()
    }
        
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
