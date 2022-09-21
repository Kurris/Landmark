//
//  ItemView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/24.
//

import SwiftUI
import Inject

struct ItemView: View {
    
    var namespace: Namespace.ID
    var travel: Travel
    
    @ObserveInjection var inject
    
    var body: some View {
        
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(travel.title)
                    .font(.largeTitle).bold()
                    .matchedGeometryEffect(id: "title\(travel.id)", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(travel.subTitle)
                    .matchedGeometryEffect(id: "subTitle\(travel.id)", in: namespace)
            }
            .padding(20)
            .background {
                Rectangle().fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .matchedGeometryEffect(id: "blur\(travel.id)", in: namespace)
                    .blur(radius: 30)
            }
        }
        .background {
            Image(travel.backgroundImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(travel.id)", in: namespace)
        }
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(travel.id)", in: namespace)
        }
        .frame(height: 300)
        .enableInjection()
    }
}

struct ItemView_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        ItemView(namespace: namespace, travel: Travel.default[0])
    }
}
