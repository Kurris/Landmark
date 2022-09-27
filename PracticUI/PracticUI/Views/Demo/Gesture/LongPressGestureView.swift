//
//  LongPressGestureView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI

struct LongPressGestureView: View {
    
    @State var count = 0
    
    var body: some View {
        Text("Count: \(count)")
            .gesture(LongPressGesture(minimumDuration: 2)
                        .onEnded({ _ in
                count+=1
            })
                        .onChanged({ value in
                print("changed:\(value)")
            }))
            
    }
}

struct LongPressGestureView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureView()
    }
}
