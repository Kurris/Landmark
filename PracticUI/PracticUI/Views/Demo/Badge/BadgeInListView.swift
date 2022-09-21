//
//  BadgeInListView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct BadgeInListView: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        VStack{
           
            List{
                Text("Wi-Fi").badge("LAN Only")
                Text("Bluetooth").badge("On")
                
                
                HStack{
                    Text("Warning")
                    Spacer()
                    Circle().fill(.red)
                        .frame(width: 28, height: 28)
                        .overlay {
                            Text("5")
                        }
                    Image(systemName: "chevron.forward")
                }
            }
        }
        .enableInjection()
    }
}

struct BadgeInListView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeInListView()
    }
}
