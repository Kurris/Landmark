//
//  FavoriteButton.swift
//  PracticeApp
//
//  Created by 李国扬 on 2022/8/19.
//

import SwiftUI

struct FavoriteButton: View {
    
    @Binding var isSet :Bool
    
    var body: some View {
        
        Button{
            isSet.toggle()
        } label: {
            Label("Toggle Favorite",systemImage: isSet ? "star.fill":"star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
