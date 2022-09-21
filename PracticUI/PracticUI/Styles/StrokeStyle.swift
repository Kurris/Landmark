//
//  StrokeStyle.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/22.
//

import SwiftUI

struct StrokeCornerRadiusStyle: ViewModifier {
    
    var cornerRadius: CGFloat
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(
                    .linearGradient(colors: [
                        .white.opacity(colorScheme == .dark ? 0.6 : 0.3),
                        .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                    ], startPoint: .top, endPoint: .bottom),
                    style: StrokeStyle(lineWidth:1)
                )
                .blendMode(.overlay)
                .shadow(color: Color.gray.opacity(0.3), radius: 20, x: 5, y: 10)
        )
    }
}


extension View {
    func strokeCornerRadiusStyle(cornerRadius: CGFloat = 30) -> some View {
        modifier(StrokeCornerRadiusStyle(cornerRadius: cornerRadius))
    }
}
