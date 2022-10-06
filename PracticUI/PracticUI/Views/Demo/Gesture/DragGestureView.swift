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
                    .onChanged{ value in
                        dragOffect = value.translation
                        
                        
                        if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                            print("left swipe")
                        }
                        else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                            print("right swipe")
                        }
                        else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
                            print("up swipe")
                        }
                        else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                            print("down swipe")
                        }
                        else {
                            print("no clue")
                        }
                    }
            )
    }
}

struct DragGestureView_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}
