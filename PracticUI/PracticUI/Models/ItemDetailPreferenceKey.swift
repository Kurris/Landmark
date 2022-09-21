//
//  ItemDetailPreferenceKey.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/24.
//

import SwiftUI

struct ItemDetailPrerenceKey: PreferenceKey {
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }

    static var defaultValue: CGFloat = 0
}
