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
    
    var body: some View {
        VStack{
            TabView(selection: $selectTab) {
                VStack{
                    
                    header2

                    TabView(selection: $activeIndex) {
                        ForEach(1 ..< 30 , id:\.self){ item in
                            Text("row #\(item)")
                                .frame(maxWidth:.infinity,maxHeight: .infinity)
                                .background(.ultraThinMaterial)
                                .tag(item)
                        }
                    }        
                    Spacer()
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(.yellow)
                .padding(20)
                .tag(MyTab.demo)
                
                VStack{}
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
        }
        .enableInjection()
    }
    
    
    var header2 : some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(1 ..< 30 ,id:\.self){ item in
                    Button {
                        withAnimation {
                            activeIndex = item
                        }
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
        let bound =  geometry[p!.bounds];
        
        let x = bound.minX;
        
        return Rectangle().fill(.blue)
            .frame(width: bound.width - 5, height: 3,alignment: .trailing)
            .cornerRadius(5)
            .offset(x:x, y:bound.height-2)
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

