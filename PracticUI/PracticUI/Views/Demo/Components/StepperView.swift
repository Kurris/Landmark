//
//  StepperView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/20.
//

import SwiftUI
import Inject

struct StepperView: View {
    
    @ObserveInjection var inject

    @State var Count = 0
    
        var body: some View {
            VStack{
                Stepper("\(Count)") {
                    Count+=1
                } onDecrement: {
                    Count-=1
                }
            }
            .enableInjection()
        }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView()
    }
}
