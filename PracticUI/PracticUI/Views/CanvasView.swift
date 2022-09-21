//
//  CanvasView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/21.
//

import SwiftUI

struct CanvasView: View {
    var arr: [Int] = [0, 1, 2, 3, 4]

    var body: some View {

        //TimelineView(.animation){ timeline in
        //  let now = timeline.date
        //  Text("value:\(now)")
        //}

        Canvas { context, size in
            //context.draw(Text("Hello world!") , at: CGPoint(x: 50, y: 50))
            //context.fill( Path(ellipseIn: CGRect(x: 50, y: 50, width: 100, height: 100)), with: .color(.yellow))
            //context.fill(Path(CGRect()), with:  )
            context.draw(Image(systemName: "person"), at: CGPoint(x: 50, y: 50))

        }
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
    }
}
