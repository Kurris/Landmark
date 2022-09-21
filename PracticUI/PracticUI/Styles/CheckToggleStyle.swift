//
//  CheckToggleStyle.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI

struct CheckToggleStyle : ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        Button{
            configuration.isOn.toggle()
        }label: {
            Label{
                configuration.label
            }icon: {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                                    .imageScale(.large)
            }
        }
        .buttonStyle(.plain)
    }
}

extension ToggleStyle  where Self == CheckToggleStyle{
    static var checkBox : Self{
        return .init()
    }
}
