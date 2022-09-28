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
    
    let sidebarContent: SidebarContent
    let mainContent: Content
    
    @Binding var isAbleShowSidebar : Bool
    @State var sidebarWidth: CGFloat = CGFloat.zero
    @State var viewState:CGSize = .zero
    
    init(isAbleShow : Binding<Bool> , @ViewBuilder sidebar: ()->SidebarContent, @ViewBuilder content: ()->Content) {
        _isAbleShowSidebar = isAbleShow
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            sidebarContent
                .offset(x: sidebarWidth > 0 ? 0 : -1 * sidebarWidth, y: 0)
                .gesture(closeDrag)
            
            mainContent
                .overlay {
                    Color.black
                        .opacity(sidebarWidth/4 * 0.01)
                        .onTapGesture {
                            withAnimation(.slide) {
                                sidebarWidth = .zero
                            }
                        }
                }
                .offset(x: sidebarWidth > 10 ? sidebarWidth : 0, y: 0)
        }
        .gesture(openDrag)
        .enableInjection()
    }
    
    
    var openDrag :  some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged({ gesture in
                guard gesture.translation.width > 0 && sidebarWidth != 225 && isAbleShowSidebar  else { return }
                
                if gesture.startLocation.x < 10 {
                    if gesture.translation.width <= 225 {
                        withAnimation(.slide) {
                            sidebarWidth = gesture.translation.width
                        }
                    }
                }
            })
            .onEnded({ gesture in
                if sidebarWidth < 100{
                    withAnimation(.slide) {
                        sidebarWidth = .zero
                    }
                }
                
                if(sidebarWidth >= 100){
                    withAnimation(.slide) {
                        sidebarWidth = 225
                    }
                }
            })
    }
    
    var closeDrag : some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged({ gesture in
                
                let width = 225 + gesture.translation.width
                if width <= 225 {
                    withAnimation(.slide) {
                        sidebarWidth = width
                    }
                }
                
            })
            .onEnded({ gesture in
                if gesture.translation.width > -80 {
                    withAnimation(.slide) {
                        sidebarWidth = 225
                    }
                }
                
                if gesture.translation.width <= -80 {
                    withAnimation(.slide) {
                        sidebarWidth = .zero
                    }
                }
            })
    }
}
