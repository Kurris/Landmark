//
//  FeaturedItemView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/23.
//

import SwiftUI

struct FeaturedItemView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()

            Text("旅途")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.blue, .white], startPoint: .topLeading, endPoint: .bottomTrailing))

            Text("望向远方")
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)

            Text("哦我我我我我我我我哦我我我我我哦我我哦我我我我我我我哦wow")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
        }

                .padding(.all, 20)
                .frame(height: 350.0)
                .background(.ultraThinMaterial)
                //.cornerRadius(20)
                .background {
                    Image("rainbow")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                }
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                //.modifier(GrayBackground())
                .strokeCornerRadiusStyle()
                .padding(.horizontal, 20)
    }
}

struct FeaturedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItemView()
    }
}
