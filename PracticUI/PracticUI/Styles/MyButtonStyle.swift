//
//  MyButtonStyle.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/14.
//

import SwiftUI
import Inject

struct MyButtonStyle: ButtonStyle {
    
    @ObserveInjection var inject
    
    @Environment(\.controlSize) var controlSize
    
    var extraPadding : CGFloat{
        switch controlSize{
            
        case .mini:
            return 0
        case .small:
            return 0
        case .regular:
            return 4
        case .large:
            return 12
        @unknown default:
            return 0
        }
    }
    
    var cornerRadius : CGFloat{
        switch controlSize{
            
        case .mini:
            return 12
        case .small:
            return 12
        case .regular:
            return 16
        case .large:
            return 20
        @unknown default:
            return 12
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal,10 + extraPadding)
            .padding(.vertical,4+extraPadding)
            .background(.quaternary, in: Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1)
            .cornerRadius(cornerRadius)
            .enableInjection()
    }
}

extension ButtonStyle where Self == MyButtonStyle{
    static var myButton: Self{
        return .init()
    }
}



struct MyButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: { print("Pressed") }) {
            Label("Press Me", systemImage: "star")
        }
        .buttonStyle(MyButtonStyle())
    }
}
