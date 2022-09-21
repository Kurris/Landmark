//
//  Tab.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/22.
//

import SwiftUI
import Inject

struct TabItemView: View {
    
    @ObserveInjection var inject
    @AppStorage("selectTab") var selectionTab: Tab = .demo
 
    @State var activeIdx : UUID = TabItem.default[0].id
    
    var body: some View {
        HStack {
            ForEach(TabItem.default){item in
                Button {
                    //dampingFraction 阻尼,动感,值越大,效果越小
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                        activeIdx = item.id
                        selectionTab = item.tab
                    }
                } label: {
                    VStack(spacing: 0) {
                        Image(systemName: item.icon)
                            .symbolVariant(selectionTab == item.tab ? .fill : .none)
                            .font(.body.bold())
                            .frame(width: 44, height: 29)
                        
                        Text(item.name)
                            .font(.caption2)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                }
                .foregroundColor(selectionTab == item.tab ? .primary : .secondary)
                .anchorPreference(key: TabReferenceKey.self, value: .bounds,
                                  transform: { [MyTextPreferenceData(viewIdx: item.id, bounds: $0)] })
            }
        }
        .overlayPreferenceValue(TabReferenceKey.self) { preferences in
            GeometryReader { geometry in
                createBorder(geometry, preferences)
            }
        }
        .padding(.top, 18)
        .frame(height: 88, alignment: .top)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34, style: .continuous))
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .coordinateSpace(name: "tabItems")
        .enableInjection()
    }
    
    func createBorder(_ geometry: GeometryProxy, _ preferences: [MyTextPreferenceData]) -> some View {

        let p = preferences.first(where: { $0.viewIdx == activeIdx })
        let bound =  geometry[p!.bounds];
        
        let x = bound.minX;
        
        let width = 28.0
        let offect = (bound.width - width )/2
        
        return Rectangle().fill(.blue)
            .frame(width: width, height: 5,alignment: .trailing)
            .cornerRadius(5)
            .offset(x: x + offect,y:-18)
       }
}



struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView()
    }
}

struct MyTextPreferenceData {
    let viewIdx: UUID
    let bounds: Anchor<CGRect>
}
