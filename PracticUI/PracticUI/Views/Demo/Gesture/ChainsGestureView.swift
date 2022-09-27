//
//  ChainsGestureView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI

struct ChainsGestureView: View {
    
    @State var message = "长按进行手势"
    
    var body: some View {
       
        
        let longPress =  LongPressGesture()
            .onEnded{ _ in
                message = "现在可以拖动"
            }
        
        let drag =   DragGesture()
            .onChanged({ gesture in
                DispatchQueue.main.async {
                    message = "X:\(gesture.location.x) Y:\(gesture.location.y)"
                }
            })
            .onEnded{ _ in
                message = "完成"
            }
        
       let combin =  longPress.sequenced(before: drag)
        Text("\(message)")
            .gesture(combin)
    }
}

struct ChainsGestureView_Previews: PreviewProvider {
    static var previews: some View {
        ChainsGestureView()
    }
}
