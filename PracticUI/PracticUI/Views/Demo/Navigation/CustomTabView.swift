//
//  CustomTabView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/2.
//

import SwiftUI
import Inject

enum MyTab{
    case demo
    case search
}


struct CustomTabView: View {
    
    @ObserveInjection var inject
    
    @State var selectTab : MyTab = .demo
    @State var activeIndex : Int = 1
    @GestureState var isDragging = false
    
    @State var currentPageOffset  = CGFloat.zero
    @State var minimumDistance  = 10.0
    
    @State var data : [Int] = [0,1,2]
    @State var headerData : [Int] = [Int](1...30)
    
    init(){
        let  appearance =  UINavigationBar.appearance()
        appearance.backgroundColor = .clear
        appearance.shadowImage = UIImage() //底部线条
    }
    
    
    var cardDrag : some Gesture{
        DragGesture(minimumDistance: minimumDistance)
            .updating($isDragging){ gesture, state, transition in
                state = true
            }
            .onChanged { value in
                guard !(activeIndex == headerData.first! && value.translation.width > 0 ) else {return}
                guard !(activeIndex == headerData.last! && value.translation.width < 0 ) else {return}
                    
                currentPageOffset =  value.translation.width
            }
    }
    
    var body: some View {
        VStack{
            
            TabView(selection: $selectTab) {
                VStack{
                    
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(.yellow)
                .padding(20)
                .tag(MyTab.demo)
                
                VStack{
                    header2
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ZStack{
                                ForEach(Array(data).filter({ v in
                                    return v != 0
                                }),id:\.self){  item in
                                    
                                    ScrollView{
                                        Text("row #\(item)")
                                            .frame(maxWidth:.infinity,maxHeight: .infinity)
                                            .frame(width : UIScreen.main.bounds.width - 40)
                                        
                                        Rectangle().fill(.yellow)
                                            .frame(width: 300, height: 400)
                                        Rectangle().fill(.yellow)
                                            .frame(width: 300, height: 400)
                                        Rectangle().fill(.yellow)
                                            .frame(width: 300, height: 400)
                                    }
                                    .offset(x: calcOffset(item))
                                    .tag(item)
                                    
                                }
                            }
                            .offset(x: currentPageOffset)
                            .gesture(cardDrag)
                        }
                    }
                    .overlay{
                        if activeIndex == headerData.first! {
                            HStack{
                                Color.white.frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .frame(width: UIScreen.main.bounds.width / 2)
                                    .opacity(0.001)
                                    .contentShape(Rectangle())
                                Spacer()
                            }
                        }
                    }
                    .onChange(of: isDragging) { _ in
                        if !isDragging {
                            
                            //to right
                            if currentPageOffset < 0 {
                                if abs(currentPageOffset) > UIScreen.main.bounds.width / 2 * 0.7{
                                    goPage(activeIndex + 1)
                                }
                                resetDrag()
                            }
                            
                            //to left
                            if currentPageOffset > 0{
                                if abs(currentPageOffset) > UIScreen.main.bounds.width / 2 * 0.7{
                                    if activeIndex != 1 {
                                        goPage(activeIndex - 1)
                                    }
                                }
                                resetDrag()
                            }
                        }
                    }
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(.blue)
                .padding(20)
                .tag(MyTab.search)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                header
            }
            
            ToolbarItem(placement: .principal) {
                Button("自定义标题"){
                    
                }
                .buttonStyle(.bordered)
            }
        }
        .enableInjection()
    }
    
    var header2 : some View{
        ScrollView(.horizontal,showsIndicators: false){
            ScrollViewReader{ proxy in
                HStack{
                    ForEach(headerData ,id:\.self){ item in
                        Button {
                            goPage(item)
                        } label: {
                            Text("\(item)")
                                .frame(width: 55, height: 55)
                                .background(.ultraThinMaterial)
                                .foregroundColor(activeIndex == item ? .black:.secondary)
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
                .onChange(of: activeIndex) { _ in
                    withAnimation {
                        proxy.scrollTo(activeIndex, anchor: .center)
                    }
                }
            }
        }
    }
    
    func goPage(_ pageIndex:Int){
        
        //to right
        if pageIndex - activeIndex > 1{
            data.remove(at: 2)
            data.append(pageIndex)
        }
        //to left
        else if pageIndex - activeIndex < -1{
            data.remove(at: 0)
            data.insert(pageIndex, at: 0)
        }
        else{
            withAnimation {
                
                data[0] = pageIndex - 1
                data[1] = pageIndex
                data[2] = pageIndex + 1
                
                resetDrag()
            }
        }
    
        withAnimation {
            activeIndex = pageIndex
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            data[1] = activeIndex
            data[0] = activeIndex - 1
            data[2] = activeIndex + 1
        }
    }
    
    func calcOffset(_ currentRow:Int) -> CGFloat{
      return  (currentRow - activeIndex) < 0 ? -358 : (currentRow - activeIndex) > 0 ? 358 : 0
    }
    
    func resetDrag(){
        withAnimation {
            currentPageOffset = 0.0
        }
    }
    
    
    
    var header : some View{
        HStack {
            Button {
                withAnimation {
                    selectTab = .demo
                }
            } label: {
                Text("Demo")
                    .foregroundColor(selectTab == .demo ? .black:.secondary)
            }
            .anchorPreference(key: CustomTabPreferenceKey.self, value: .bounds,
                              transform: { [CustomTabPreferenceKeyPreferenceData(viewIdx: .demo, bounds: $0)] })
            
            
            Button {
                withAnimation {
                    selectTab = .search
                }
            } label: {
                Text("Search")
                    .foregroundColor(selectTab == .search ? .black:.secondary)
            }
            .anchorPreference(key: CustomTabPreferenceKey.self, value: .bounds,
                              transform: { [CustomTabPreferenceKeyPreferenceData(viewIdx: .search, bounds: $0)] })
        }
        .overlayPreferenceValue(CustomTabPreferenceKey.self) { preferences in
            GeometryReader { geometry in
                createBorder(geometry,preferences)
            }
        }
    }
    
    func createBorder(_ geometry: GeometryProxy, _ preferences: [CustomTabPreferenceKeyPreferenceData]) -> some View {
        
        let p = preferences.first(where: { $0.viewIdx == selectTab })
        let bound =  geometry[p!.bounds];
        
        let x = bound.minX;
        
        return Rectangle().fill(.blue)
            .frame(width: bound.width - 5, height: 3,alignment: .trailing)
            .cornerRadius(5)
            .offset(x:x, y:bound.height)
    }
    
    
    func createBorder2(_ geometry: GeometryProxy, _ preferences: [CustomTabPreferenceKeyPreferenceData2]) -> some View {
        
        let p = preferences.first(where: { $0.viewIdx == activeIndex })
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
}

struct CustomTabPreferenceKeyPreferenceData {
    let viewIdx: MyTab
    let bounds: Anchor<CGRect>
}

struct CustomTabPreferenceKey : PreferenceKey {
    
    typealias Value = [CustomTabPreferenceKeyPreferenceData]
    
    static var defaultValue: [CustomTabPreferenceKeyPreferenceData] = []
    
    static func reduce(value: inout [CustomTabPreferenceKeyPreferenceData], nextValue: () -> [CustomTabPreferenceKeyPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}



struct CustomTabPreferenceKeyPreferenceData2 {
    let viewIdx: Int
    let bounds: Anchor<CGRect>
}

struct CustomTabPreferenceKey2 : PreferenceKey {
    
    typealias Value = [CustomTabPreferenceKeyPreferenceData2]
    
    static var defaultValue: [CustomTabPreferenceKeyPreferenceData2] = []
    
    static func reduce(value: inout [CustomTabPreferenceKeyPreferenceData2], nextValue: () -> [CustomTabPreferenceKeyPreferenceData2]) {
        value.append(contentsOf: nextValue())
    }
}

