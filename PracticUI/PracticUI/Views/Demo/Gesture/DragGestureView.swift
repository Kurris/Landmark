//
//  DragGestureView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI

struct DragGestureView: View {
    
    @State var dragOffect = CGSize.zero
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .offset(dragOffect)
            .gesture(
                DragGesture()
                    .onEnded{ _ in
                        dragOffect = .zero
                    }
                    .onChanged{ gesture in
                        dragOffect = gesture.translation
                    }
            )
    }
}

struct DragGestureView_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}
