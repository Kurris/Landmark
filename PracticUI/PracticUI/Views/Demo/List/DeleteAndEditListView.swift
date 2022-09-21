//
//  ListView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct DeleteAndEditListView: View {
    
    @ObserveInjection var inject
    
    @State var users:[String] = ["li","wang","shang","pan"]
    
    var body: some View {
        List{
            ForEach(users, id: \.self){ item in
                Text("row #\(item)")
            }
            .onDelete { index in
                users.remove(atOffsets: index)
            }
        }
        .toolbar(content: {
            EditButton()
        })
        .enableInjection()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAndEditListView()
    }
}
