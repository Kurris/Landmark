//
//  SimultaneousGestureView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI

struct SimultaneousGestureView: View {
    var body: some View {
        TapGestureView()
            .simultaneousGesture(
                TapGesture()
                    .onEnded({ _ in
                        print("out print")
                    })
            )
    }
}

struct SimultaneousGestureView_Previews: PreviewProvider {
    static var previews: some View {
        SimultaneousGestureView()
    }
}
