//
//  ItemView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/24.
//

import SwiftUI
import Inject

struct ItemEmptyView: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
            }
            .padding(20)
            .background {
                Color.clear
            }
        }
        .frame(height: 300)
        .padding(20)
        .enableInjection()
    }
}
