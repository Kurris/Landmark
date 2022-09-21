//
//  TabPageView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/23.
//

import SwiftUI

struct TabPageView: View {
    var body: some View {
        TabView {
            ForEach(/*@START_MENU_TOKEN@*/0..<5/*@END_MENU_TOKEN@*/) { item in
//                GeometryReader { proxy in
//                    let minX = proxy.frame(in: .global).minX

                FeaturedItemView()
                        .padding(.vertical, 30)
                        //.rotation3DEffect(.degrees( minX / -20), axis: (x: 0, y: 1, z: 0) )
                        .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 10)
                //.blur(radius: abs(minX / 40))
//                }
            }
        }
                //indexDisplayMode 轮播图的 当前页指示
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 400)
    }
}

struct TabPageView_Previews: PreviewProvider {
    static var previews: some View {
        TabPageView()
    }
}
