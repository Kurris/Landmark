//
//  ShakeFeedbackView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/29.
//

import SwiftUI
import Inject

struct ShakeFeedbackView: View {
    
    @ObserveInjection var inject
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        VStack{

            Button("Success"){
                generator.notificationOccurred(.success)
            }
            .buttonStyle(.bordered)
            
            Button("Warning"){
                generator.notificationOccurred(.warning)
            }
            .buttonStyle(.bordered)
            
            Button("Error"){
                generator.notificationOccurred(.error)
            }
            .buttonStyle(.bordered)
        }
        .enableInjection()
    }
}

struct ShakeFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        ShakeFeedbackView()
    }
}
