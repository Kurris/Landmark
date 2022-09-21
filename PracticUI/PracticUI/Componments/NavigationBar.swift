//
//  NavigationBar.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/22.
//

import SwiftUI
import Inject

struct NavigationBar: View {
    @ObserveInjection var inject
    var title: String
    //@Binding 不可初始化
    @Binding var hasScrolled: Bool
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack {
            Color.clear.background(.ultraThinMaterial)
                .opacity(hasScrolled ? 1 : 0)
            
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: hasScrolled ? .center : .leading)
                    .padding(.leading, hasScrolled ? 0 : 20)
                    .padding(.top, hasScrolled ? 10 : 0)
                    .animatableFont(size: hasScrolled ? 18 : 34, weight: hasScrolled ? .regular : .bold)
                
            }
            .offset(y: hasScrolled ? -8 : 0)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .frame(width: 32, height: 32)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .strokeCornerRadiusStyle(cornerRadius: 14)
                    .onTapGesture {
                        model.isShowSearch.toggle()
                    }
                
                Image(systemName: "person.crop.circle")
                    .frame(width: 32, height: 32)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .strokeCornerRadiusStyle(cornerRadius: 14)
                    .onTapGesture {
                        model.isShowAccountSheet = true
                    }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .offset(y: hasScrolled ? -8 : 0)
        }
        .frame(height: hasScrolled ? 50 : 80)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: hasScrolled ? -8 : 0)
        .enableInjection()
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Featured", hasScrolled: .constant(true))
            .environmentObject(Model())
    }
}
