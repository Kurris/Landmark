//
//  InputStyle.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/15.
//

import SwiftUI

struct InputStyle: ViewModifier {
    
    var icon : String = ""
    
    func body(content: Content) -> some View {
        content.padding()
            .padding(.leading,40)
            .background(.thinMaterial , in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .strokeCornerRadiusStyle(cornerRadius: 20)
            .overlay {
                if !icon.isEmpty{
                    Image(systemName: icon)
                        .foregroundColor(.secondary)
                        .frame(width: 36, height: 36)
                        .background(.thinMaterial,in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(8)
                }
            }
    }
}


extension View{
    func inputStyle(icon: String) -> some View {
        modifier(InputStyle(icon: icon))
    }
}
