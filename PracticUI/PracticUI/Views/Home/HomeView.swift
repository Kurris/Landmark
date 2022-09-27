//
//  HomeView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/22.
//

import SwiftUI
import Inject

struct HomeView: View {
    
    @ObserveInjection var inject
    
    @State var hasScroll = false
    @Namespace var namespace
    @EnvironmentObject var model: Model
 
    var body: some View {
        home.enableInjection()
    }
    
    
    
    var home : some View{
        ZStack {
           ScrollView {
               
               scrollDetection
               
               withAnimation(.easeInOut(duration: 0.1)) {
                   TabPageView()
               }
               
               LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))],spacing: 10) {
                   if !model.isShowCardDetail {
                       ForEach(Travel.default) { travel in
                           ItemView(namespace: namespace, travel: travel)
                               .onTapGesture {
                                   withAnimation(.toOpen) {
                                       model.isShowCardDetail.toggle()
                                       model.cardSelectedId = travel.id
                                   }
                               }
                       }
                   } else {
                       ForEach(Travel.default) { travel in
                           ItemEmptyView()
                               .opacity(0.2)
                       }
                   }
               }
               .padding(10)
           }
           //创建坐标系空间
           .coordinateSpace(name: "scroll")
           //生成一个高度70的安全区域
           .safeAreaInset(edge: .top, content: {
               Color.clear.frame(height: 70)
           })
           .sheet(isPresented: $model.isShowAccountSheet) {
               AccountView()
           }
           .sheet(isPresented: $model.isShowSearch) {
               SearchView()
           }
           .overlay {
               NavigationBar(title: "Featured", hasScrolled: $hasScroll)
           }
           
           
           if model.isShowCardDetail {
               ForEach(Travel.default) { travel in
                   if model.cardSelectedId == travel.id {
                       ItemDetailView(namespace: namespace, travel: travel)
                           .zIndex(3)
                           .transition(.asymmetric(
                               insertion: .opacity.animation(.easeInOut(duration: 0.05)),
                               removal: .opacity.animation(.easeInOut(duration: 0.6))))
                   }
               }
           }
           
           
       }.enableInjection()
    }
    
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            //named定义一样名为scroll的位置
            Color.clear.preference(key: ScrollPreferenceKey.self,
                                   value: proxy.frame(in: .named("scroll")).minY)
        }
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                hasScroll = value < 0
            }
        })
        .frame(height: 0)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.portrait)
            .environmentObject(Model())
    }
}
