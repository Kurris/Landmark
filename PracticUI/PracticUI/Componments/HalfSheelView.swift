//
//  HalfSheelView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/27.
//

import SwiftUI


struct Handle : View {
    private let handleThickness = CGFloat(5.0)
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 40, height: handleThickness)
            .foregroundColor(Color.secondary)
            .padding(5)
    }
}

struct HalfModel<Content: View>: View {
    @State var dragY = UIScreen.main.bounds.height / 2
    @Binding var show: Bool
    var content: () -> Content
    var body: some View {
        let maxHeight = UIScreen.main.bounds.height
        ZStack {
            if show {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        show = false
                    }.onAppear(perform: {
                        print("appear")
                        dragY = maxHeight / 2
                    })
            }
            
            VStack {
                Handle()
                self.content()
                // 如果content是Picker类控件会和drag产生冲突，加上下面这句就不会了
                    .onTapGesture {}
            }.background(Color.white)
            .cornerRadius(10.0)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
            .offset(y: show ? dragY : maxHeight)
            .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        dragY = gesture.location.y
                    })
                    .onEnded({gesture in
                        if dragY > maxHeight * 0.7 {
                            dragY = maxHeight
                            show = false
                        } else {
                            dragY = maxHeight / 2
                        }
                    })
            )
            
        }
    }
}


