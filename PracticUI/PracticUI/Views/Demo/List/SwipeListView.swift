//
//  SwipeList.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct SwipeListView: View {
    
    @ObserveInjection var inject
    
    @State var users:[String] = ["li","wang","shang","pan"]
    
    var body: some View {
        VStack{
            List{
                ForEach(users, id: \.self){ item in
                    Text("row #\(item)")
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button("Delete"){
                                print("Delete...")
                            }
                            .tint(.red)
                            
                            Button("Marked"){
                                print("Marked...")
                            }
                        }
                }
                
                //.listRowSeparator(.hidden)
//                .listRowBackground(Color.blue)
            }
            //.listStyle(.grouped)
        }
        .enableInjection()
    }
}

struct SwipeList_Previews: PreviewProvider {
    static var previews: some View {
        SwipeListView()
    }
}
