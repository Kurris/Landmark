//
//  ContextMenuView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/20.
//

import SwiftUI
import Inject

struct ContextMenuView: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        Text("Options")
            .contextMenu {
                Button {
                    print("Change country setting")
                } label: {
                    Label("Choose Country", systemImage: "globe")
                }

                Button {
                    print("Enable geolocation")
                } label: {
                    Label("Detect Location", systemImage: "location.circle")
                }
            }
            .enableInjection()
    }
}

struct ContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuView()
    }
}
