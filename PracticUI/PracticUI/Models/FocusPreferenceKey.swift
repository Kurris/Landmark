//
//  FocusPreferenceKey.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/15.
//

import SwiftUI

struct FocusPreferenceKey: PreferenceKey {

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }

    static var defaultValue: CGFloat = 0
}
