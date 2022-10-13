//
//  HalfSheelView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/27.
//

import SwiftUI
import Inject


struct BaseSheetView<Content: View,Title: View> : View {
    
    @ObserveInjection var inject
    
    @Binding var isShow: Bool
    let insideContent : Content
    let insideTitle : Title
    let draggable : Bool
    
    let heigh :CGFloat
    let insideCloseButton :  Bool
    
    @State var offsetY = CGFloat.zero
    @State var minY = CGFloat.zero
    @GestureState var isDragging = false
    
    init(show: Binding<Bool>, draggable : Bool  , heigh: CGFloat
         , showCloseButton : Bool
         , @ViewBuilder content: () -> Content
         , @ViewBuilder title:() -> Title){
        self._isShow = show
        self.draggable = draggable
        self.heigh = heigh
        insideCloseButton = showCloseButton
        insideContent = content()
        insideTitle = title()
    }
    
    var body: some View {
        ZStack{
            if isShow {
                Color.black.opacity(0.2)
                    .onTapGesture {
                        toClose()
                    }
            }
            VStack{
                Spacer()
                drawer
            }
        }
        .onChange(of: isShow){ _ in
            if isShow {
                toShow()
            }
        }
        .onChange(of: offsetY ) { _ in
            if offsetY != 0.0 {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
        }
        .onAppear(perform: {
            offsetY = heigh
        })
        .frame(maxWidth : .infinity , maxHeight: .infinity)
        .enableInjection()
    }
    
    func toShow() {
        withAnimation(.slide){
            offsetY = 0.0
        }
    }
    
    func toClose() {
        withAnimation(.slide){
            offsetY = heigh
            isShow = false
        }
        
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
    
    
    
    var drawer : some View{
        VStack{
            
            HStack{
                insideTitle
            }
            .frame(height:40)
            .overlay {
                if insideCloseButton{
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                        .font(.body.bold())
                        .offset(x: UIScreen.main.bounds.width/2 - 30)
                        .onTapGesture {
                            toClose()
                        }
                }
            }
            
            insideContent
            Spacer()
        }
        .frame(maxWidth : .infinity,maxHeight: .infinity)
        .frame(height: heigh)
        .background(Color.white)
        .cornerRadius(18.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        .offset(y: offsetY)
        .gesture(draggable ? drag : nil)
        .onChange(of: isDragging) { _ in
            if !isDragging{
                guard offsetY > 0.0 else { return }
                
                let limit = heigh / 2 * 0.7
                withAnimation(.slide) {
                    if offsetY > limit {
                        toClose()
                    }
                    else {
                        toShow()
                    }
                }
            }
        }
    }
    
    var drag : some Gesture{
        DragGesture(coordinateSpace: .local)
            .updating($isDragging, body: { _, state, _ in
                state = true
            })
            .onChanged{ gesture in
                
                guard gesture.location.y > 0 && gesture.translation.height > 0 else { return }
                
                withAnimation(.slide){
                    //水平滑动
                    if gesture.startLocation.y > 40 && gesture.translation.width > 0  {
                        offsetY = gesture.translation.width
                    }
                    //锤子滑动
                    else if gesture.startLocation.y <= 40 && gesture.startLocation.y > 0  {
                        offsetY = gesture.translation.height
                    }
                }
            }
    }
}



struct BaseSheet<InsideContent:View,Title:View> : ViewModifier {
    
    @Binding var isShow : Bool
    let content : ()->InsideContent
    let title : ()->Title
    let heigh : CGFloat
    let draggable :Bool
    let isShowCloseButton : Bool
    
    func body(content: Content) -> some View {
        content.overlay{
            BaseSheetView(show: $isShow, draggable: draggable, heigh: heigh, showCloseButton: isShowCloseButton) {
                self.content()
            } title: {
                title()
            }
        }
        .ignoresSafeArea()
    }
}

extension View {
    func baseSheet<Content:View,Title:View>(isShow: Binding<Bool>
                                            ,draggable:Bool
                                            ,isShowCloseButton : Bool
                                            , heigh : CGFloat
                                            ,@ViewBuilder content:@escaping ()->Content
                                            ,@ViewBuilder title:@escaping ()->Title) -> some View {
        modifier(BaseSheet(isShow: isShow, content: content, title: title, heigh: heigh, draggable: draggable, isShowCloseButton: isShowCloseButton))
    }
}


