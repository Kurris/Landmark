//
//  AnimationStyle.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/24.
//

import SwiftUI

extension Animation {
    static let toOpen = Animation.spring(response: 0.5, dampingFraction: 0.7)
    static let toClose = Animation.spring(response: 0.6, dampingFraction: 0.9)
    
    static let slide = Animation.spring(response: 0.1)
}
