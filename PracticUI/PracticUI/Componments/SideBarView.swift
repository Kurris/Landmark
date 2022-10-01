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
    @State var offsetX = CGFloat.zero
    
    init(isAbleShow : Binding<Bool> , @ViewBuilder sidebar: ()->SidebarContent, @ViewBuilder content: ()->Content) {
        _isAbleShowSidebar = isAbleShow
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        ZStack{
            mainContent
                .overlay {
                    Color.black
                        .opacity(offsetX / 20 * 0.01)
                        .onTapGesture {
                            withAnimation(.slide) {
                                offsetX = .zero
                            }
                        }
                }
                .gesture(openDrag)
            
            HStack{
                sidebarContent
                    .frame(width: UIScreen.main.bounds.width/2 + UIScreen.main.bounds.width / 4)
                    .offset(x: offsetX + (-UIScreen.main.bounds.width/2-UIScreen.main.bounds.width / 4))
                    .gesture(closeDrag)
                                            
                Spacer()
            }
        }
        .onChange(of: isOpenDrag, perform: { _ in
            if isOpenDrag{
                if offsetX > 0{
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
        .enableInjection()
    }
    
    func endDragWhenOpen(){
        let limit = UIScreen.main.bounds.width / 4 * 0.7
        if offsetX < limit{
            withAnimation(.slide) {
                offsetX = 0.0
            }
        }
        
        if(offsetX >= limit){
            withAnimation(.slide) {
                offsetX = UIScreen.main.bounds.width/2 + UIScreen.main.bounds.width / 4
            }
        }
    }
    
    func endDragWhenClose(){
        let limit = UIScreen.main.bounds.width / 4 * 0.7
        let maxWidth = UIScreen.main.bounds.width/2 + UIScreen.main.bounds.width / 4
        
        if maxWidth - offsetX > limit {
            withAnimation(.slide) {
                offsetX = .zero
            }
        }else{
            withAnimation(.slide) {
                offsetX = maxWidth
            }
        }
    }
    
    var openDrag :  some Gesture {
        DragGesture(minimumDistance: 10, coordinateSpace: .local)
            .updating($isOpenDrag) { gesture, state, transaction in
                if gesture.startLocation.x < 10 {
                    state  = true
                }
            }
            .onChanged({ gesture in
                let maxWidth = UIScreen.main.bounds.width/2 + UIScreen.main.bounds.width / 4
                let translationWidth = gesture.translation.width

                let able = gesture.startLocation.x > 0
                && isOpenDrag
                && gesture.startLocation.x <= maxWidth
                &&  translationWidth > 0
                && isAbleShowSidebar
                && translationWidth <= maxWidth
            
                guard  able else { return }

                withAnimation(.slide) {
                    offsetX = gesture.translation.width
                }
            })
    }
    
    var closeDrag : some Gesture {
        DragGesture(coordinateSpace: .local)
            .updating($isCloseDrag) { gesture, state, transaction in
                state  = true
            }
            .onChanged{ gesture in
                let maxWidth = UIScreen.main.bounds.width/2 + UIScreen.main.bounds.width / 4
                let width = maxWidth + gesture.translation.width

                if offsetX > 0 && width <= maxWidth {
                    withAnimation(.slide) {
                        offsetX = width
                    }
                }
            }
    }
}
