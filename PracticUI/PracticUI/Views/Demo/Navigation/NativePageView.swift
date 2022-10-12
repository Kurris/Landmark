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
    
    @State var pages : [PageModel] = [PageModel(name: "mainPage"),PageModel(name: "page1",isNativePage: true)]
    
    @State var minimumDistance = 30.0
    
    
    @State var currentIndex:Int = 0
    func currentPage() -> PageModel {
        if currentIndex == 1 {
            return page1
        }else if currentIndex == 2 {
            return page2
        }else{
            return page
        }
    }
    
    var body: some View {
        ZStack{
            PaginationView(pageModel: page , minimumDistance: 30.0) { index in
                
                List{
                    Button("current0"){
                        withAnimation {
                            page.draggingOffset = -(UIScreen.main.bounds.width/4)
                            page1.draggingOffset = 0
                            currentIndex = 1
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }.onAppear{
                page.total = 1
                page1.total = 1
                page2.total = 1
            }
            .onChange(of: page.draggingOffset) { newValue in
                if page.draggingOffset < 0 {
                    minimumDistance = 10.0
                }else{
                    minimumDistance = 30.0
                }
            }
            PaginationView(pageModel: page1,minimumDistance: 10.0,onSwipeChanging: { width in
                page.draggingOffset = -(UIScreen.main.bounds.width/4) + width / 4
                if page.draggingOffset == 0{
                    currentIndex = 0
                }
            }) { index in
                List{
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
            
            PaginationView(pageModel: page2 , minimumDistance: minimumDistance,onSwipeChanging: { width in
                page1.draggingOffset = -(UIScreen.main.bounds.width/4) + width / 4
                if page1.draggingOffset == 0{
                    currentIndex = 1
                    page2.draggingOffset = UIScreen.main.bounds.width * 2
                }
            }) { index in
                List{
                    Button("current2"){

                    }
                    .buttonStyle(.bordered)
                }
            }
            .onAppear {
                page2.draggingOffset = UIScreen.main.bounds.width * 2
            }
            .allowsHitTesting(currentIndex == 2)
        }
        .enableInjection()
    }
}

struct NativePageView_Previews: PreviewProvider {
    static var previews: some View {
        NativePageView()
    }
}
