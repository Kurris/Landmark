//
//  CircleImage.swift
//  PracticeApp
//
//  Created by 李国扬 on 2022/8/19.
//

import SwiftUI

struct CircleImage: View {
    var image:Image
    
    var body: some View {
        image
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.gray, lineWidth: 4)
            }
            .shadow(radius: 7)
            
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image:Image("turtlerock"))
    }
}
