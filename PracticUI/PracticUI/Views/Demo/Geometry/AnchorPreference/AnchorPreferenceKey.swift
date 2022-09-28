//
//  AnchorPreferenceKey.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/28.
//

import SwiftUI

struct AnchorPreferenceKeyPreferenceData {
    let viewIdx: Int
    let bounds: Anchor<CGRect>
}

struct AnchorPreferenceKey : PreferenceKey {
    
    typealias Value = [AnchorPreferenceKeyPreferenceData]
    
    static var defaultValue: [AnchorPreferenceKeyPreferenceData] = []
    
    static func reduce(value: inout [AnchorPreferenceKeyPreferenceData], nextValue: () -> [AnchorPreferenceKeyPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}
