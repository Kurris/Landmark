//
//  NativePageView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/12.
//

import SwiftUI
import Inject

struct NativePageView: View {
    
    @ObserveInjection var inject
    
    @StateObject var page : PageModel = PageModel(name: "mainPage")
    @StateObject var page1 : PageModel = PageModel(name: "page1",isNativePage: true)
    @StateObject var page2 : PageModel = PageModel(name: "page2",isNativePage: true)
     
    @State var currentIndex:Int = 0
    
    var body: some View {
        ZStack{
            PaginationView(pageModel: page , minimumDistance: 30.0) { index in
                
                Color.orange.overlay{
                    Button("current0"){
                        withAnimation {
                            page.draggingOffset = -(UIScreen.main.bounds.width/4)
                            page1.draggingOffset = 0
                            currentIndex = 1
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
            }
            
            PaginationView(pageModel: page1,minimumDistance: 10.0,onSwipeChanging: { width in
                withAnimation(.slide) {
                    page.draggingOffset = -(UIScreen.main.bounds.width/4) + width / 4
                }
                if page.draggingOffset == 0{
                    currentIndex = 0
                }
            }) { index in
                Color.pink.overlay{
                    Button("current1"){
                        withAnimation {
                            page1.draggingOffset = -(UIScreen.main.bounds.width/4)
                            page2.draggingOffset = 0
                            currentIndex = 2
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
            .allowsHitTesting(currentIndex == 1)
            
            PaginationView(pageModel: page2 , minimumDistance: 10.0,onSwipeChanging: { width in
                withAnimation(.slide) {
                    page1.draggingOffset = -(UIScreen.main.bounds.width/4) + width / 4
                }
                if page1.draggingOffset == 0{
                    currentIndex = 1
                }
            }) { index in
                Color.yellow.overlay{
                    Button("current2"){

                    }
                    .buttonStyle(.bordered)
                }
            }
            .allowsHitTesting(currentIndex == 2)
        }
        .ignoresSafeArea()
        .enableInjection()
    }
}

struct NativePageView_Previews: PreviewProvider {
    static var previews: some View {
        NativePageView()
    }
}
