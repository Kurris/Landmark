//
//  GradientColor.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/21.
//

import SwiftUI

struct GrayBackground: ViewModifier {
    func body(content: Content) -> some View {
        content.background(.background)
    }
}


extension View {
    func grayBackground() -> some View {
        modifier(GrayBackground())
    }
}
