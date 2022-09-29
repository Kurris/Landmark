//
//  SideBarView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/27.
//

import SwiftUI
import Inject

struct SideBarView<SidebarContent: View, Content: View>: View {
    
    @ObserveInjection var inject
    
    
    @Binding var isAbleShowSidebar : Bool
    let sidebarContent: SidebarContent
    let mainContent: Content
    
    @GestureState var isOpenDrag = false
    @GestureState var isCloseDrag = false
    @State var dragWidth = CGFloat.zero
    
    init(isAbleShow : Binding<Bool> , @ViewBuilder sidebar: ()->SidebarContent, @ViewBuilder content: ()->Content) {
        _isAbleShowSidebar = isAbleShow
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            sidebarContent
                .offset(x: dragWidth > 0 ? 0 : -1 * dragWidth, y: 0)
                .gesture(closeDrag)
            
            mainContent
                .overlay {
                    Color.black
                        .opacity(dragWidth/20 * 0.01)
                        .onTapGesture {
                            withAnimation(.slide) {
                                //sidebarWidth = 0.0
                            }
                        }
                }
                .offset(x:dragWidth)
        }
        .onChange(of: isOpenDrag, perform: { _ in
            if isOpenDrag{
                if dragWidth > 0{
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                }
            }
            else{
                endDragWhenOpen()
            }
        })
        .onChange(of: isCloseDrag, perform: { _ in
            if !isCloseDrag{
                endDragWhenClose()
            }
        })
        .gesture(openDrag)
        .enableInjection()
    }
    
    func endDragWhenOpen(){
        let limit = UIScreen.main.bounds.width / 4 * 0.7
        if dragWidth < limit{
            withAnimation(.slide) {
                dragWidth = 0.0
            }
        }
        
        if(dragWidth >= limit){
            withAnimation(.slide) {
                dragWidth = UIScreen.main.bounds.width/2 + UIScreen.main.bounds.width / 4
            }
        }
    }
    
    func endDragWhenClose(){
        let limit = UIScreen.main.bounds.width / 4 * 0.7
        let maxWidth = UIScreen.main.bounds.width/2 + UIScreen.main.bounds.width / 4
        
        if maxWidth - dragWidth > limit {
            withAnimation(.slide) {
                dragWidth = .zero
            }
        }else{
            withAnimation(.slide) {
                dragWidth = maxWidth
            }
        }
    }
    
    var openDrag :  some Gesture {
        DragGesture()
            .updating($isOpenDrag) { gesture, state, transaction in
                if gesture.startLocation.x < 20 {
                    state  = true
                }
            }
            .onChanged({ gesture in
                let maxWidth = UIScreen.main.bounds.width/2 + UIScreen.main.bounds.width / 4
                let translationWidth = gesture.translation.width
                
                guard  gesture.startLocation.x>0
                        && isOpenDrag
                        && gesture.startLocation.x <= maxWidth
                        &&  translationWidth > 0
                        && isAbleShowSidebar
                        && translationWidth <= maxWidth else { return }
                
                
                withAnimation(.slide) {
                    dragWidth = gesture.translation.width
                }
            })
    }
    
    var closeDrag : some Gesture {
        DragGesture(minimumDistance: 10)
            .updating($isCloseDrag) { gesture, state, transaction in
                state  = true
            }
            .onChanged{ gesture in
                let maxWidth = UIScreen.main.bounds.width/2 + UIScreen.main.bounds.width / 4
                let width = maxWidth + gesture.translation.width
                
                if dragWidth > 0 && width <= maxWidth {
                    withAnimation(.slide) {
                        dragWidth = width
                    }
                }
            }
    }
}
