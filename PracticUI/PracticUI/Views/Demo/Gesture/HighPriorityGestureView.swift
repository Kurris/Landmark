//
//  HighPriorityGestureView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI

struct HighPriorityGestureView: View {
    var body: some View {
       TapGestureView()
            .highPriorityGesture(
                TapGesture()
                    .onEnded({ _ in
                        print("high priority")
                    })
            )
    }
}

struct HighPriorityGestureView_Previews: PreviewProvider {
    static var previews: some View {
        HighPriorityGestureView()
    }
}
