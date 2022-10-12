//
//  NestedPageView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/9.
//

import SwiftUI
import Inject
import AVFoundation

struct NestedPageView: View {
    
    @ObserveInjection var inject
    
    @State var headerData : [Int] = [Int](0...30)
    
    @State var isHidden = false
    
    @StateObject var pPage : PageModel = PageModel(name: "parent",indexes: [0,1])
    @StateObject var page2 : PageModel = PageModel(name: "child2",indexes:[0,1,2])
    @StateObject var page1 : PageModel = PageModel(name: "child1",indexes:[0,1])
    
    var body: some View {
        VStack{
            PaginationView(pageModel: pPage) { index in
                if index == 0 {
                    VStack{
                        Text("只有俩页")
                     mainPage
                    }
                    .onAppear {
                        page1.total = 2
                    }
                }
                else if index == 1 {
                   VStack{
                      header2
                      pagination2
                   }
                   .onAppear {
                       page2.total = headerData.count
                   }
                }
            }
        }
        .ignoresSafeArea(.all , edges: [.bottom])
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                header
            }
            
            ToolbarItem(placement: .principal) {
                Button(action: {
                    
                }, label: {
                    Text("自定义标题")
                })
                .buttonStyle(.bordered)
            }
        }
        .navigationBarBackButtonHidden(true)
        .enableInjection()
    }
    
    var mainPage : some View{
        PaginationView(pageModel: page1,onSwipeChanging: { width in
                    if width < 0 && page1.activeIndex == page1.indexes.count - 1{
                            withAnimation {
                                pPage.draggingOffset = width
                            }
                        }
        },onDragChanged: { isDragging in
                        if !isDragging && page1.activeIndex == page1.indexes.count - 1 {
                            //to right
                            if pPage.draggingOffset < 0 {
                                if abs(pPage.draggingOffset) > UIScreen.main.bounds.width / 2 * 0.7{
                                    pPage.goPage(pPage.activeIndex + 1)
                                }
                                pPage.resetDrag()
                            }

                            //to left
                            if pPage.draggingOffset > 0{
                                if abs(pPage.draggingOffset) > UIScreen.main.bounds.width / 2 * 0.7{
                                    pPage.goPage(pPage.activeIndex - 1)
                                }
                                pPage.resetDrag()
                            }
                        }
        }){ index in
            ScrollView{
                Text("row #\(index + 1)")
                    .frame(maxWidth:.infinity,maxHeight: .infinity)
                    .frame(width : UIScreen.main.bounds.width)


                Group{
                    Rectangle().fill(.blue)
                    Rectangle().fill(.blue)
                    Rectangle().fill(.blue)
                }
                .frame(width:300,height: 300)
            }
        }
    }
    
    var pagination2 : some View{
        PaginationView(pageModel: page2,onSwipeChanging: { width in
            if width > 0 && page2.activeIndex == 0{
                withAnimation {
                    pPage.draggingOffset = width
                }
            }
            
        },onDragChanged: { isDragging in
            if !isDragging && page2.activeIndex == 0 {
                //to right
                if pPage.draggingOffset < 0 {
                    if abs(pPage.draggingOffset) > UIScreen.main.bounds.width / 2 * 0.7{
                        pPage.goPage(pPage.activeIndex + 1)
                    }
                    pPage.resetDrag()
                }

                //to left
                if pPage.draggingOffset > 0{
                    if abs(pPage.draggingOffset) > UIScreen.main.bounds.width / 2 * 0.7{
                        pPage.goPage(pPage.activeIndex - 1)
                    }
                    pPage.resetDrag()
                }
            }
        }){ index in
            ScrollView{
                Text("row #\(index)")
                    .frame(maxWidth:.infinity,maxHeight: .infinity)
                    .frame(width : UIScreen.main.bounds.width)
                
                
                Group{
                    Rectangle().fill(.yellow)
                    Rectangle().fill(.yellow)
                    Rectangle().fill(.yellow)
                }
                .frame(width:300,height: 300)
            }
        }
    }
    
    var header2 : some View{
        ScrollView(.horizontal,showsIndicators: false){
            ScrollViewReader{ proxy in
                HStack{
                    ForEach(headerData ,id:\.self){ item in
                        Button {
                            page2.goPage(item)
                        } label: {
                            Text("\(item)")
                                .frame(width: 55, height: 55)
                                .background(.ultraThinMaterial)
                                .foregroundColor(page2.activeIndex == item ? .black:.secondary)
                        }
                        .anchorPreference(key: CustomTabPreferenceKey2.self, value: .bounds,
                                          transform: { [CustomTabPreferenceKeyPreferenceData2(viewIdx: item, bounds: $0)] })
                    }
                }
                .overlayPreferenceValue(CustomTabPreferenceKey2.self) { preferences in
                    GeometryReader { geometry in
                        createBorder2(geometry, preferences)
                    }
                }
                .onChange(of: page2.activeIndex) { _ in
                    withAnimation {
                        proxy.scrollTo(page2.activeIndex, anchor: .center)
                    }
                }
            }
        }
    }


    func createBorder2(_ geometry: GeometryProxy, _ preferences: [CustomTabPreferenceKeyPreferenceData2]) -> some View {

        let p = preferences.first(where: { $0.viewIdx == page2.activeIndex })
        if p == nil{
            return AnyView( Group{
                EmptyView()
            })
        }
        let bound =  geometry[p!.bounds];

        let x = bound.minX;

        return AnyView(Group{
            Rectangle().fill(.yellow)
                .frame(width: bound.width, height: 5,alignment: .trailing)
                .cornerRadius(5)
                .offset(x:x, y: bound.height-5)
        })
    }

    var header : some View{
        HStack {
            
            ForEach([0,1],id:\.self){ item in
                Button {
                    withAnimation {
                        pPage.activeIndex = item
                    }
                } label: {
                    Text("第\(item + 1)页")
                        .foregroundColor(pPage.activeIndex == item ? .black:.secondary)
                }
                .anchorPreference(key: CustomTabPreferenceKey.self, value: .bounds,
                                  transform: { [CustomTabPreferenceKeyPreferenceData(viewIdx: item, bounds: $0)] })
            }
        }
        .overlayPreferenceValue(CustomTabPreferenceKey.self) { preferences in
            GeometryReader { geometry in
                createBorder(geometry,preferences)
            }
        }
    }

    func createBorder(_ geometry: GeometryProxy, _ preferences: [CustomTabPreferenceKeyPreferenceData]) -> some View {

        let p = preferences.first(where: { $0.viewIdx == pPage.activeIndex })
        let bound =  geometry[p!.bounds];

        let x = bound.minX;

        return Rectangle().fill(.blue)
            .frame(width: bound.width - 5, height: 3,alignment: .trailing)
            .cornerRadius(5)
            .offset(x:x, y:bound.height)
    }
}

struct NestedPageView_Previews: PreviewProvider {
    static var previews: some View {
        NestedPageView()
    }
}
