//
//  ExpandListView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct MyUser : Identifiable{
    
    var id  = UUID()
    var name:String
    var children:[MyUser]?
    
    
    static var `default` : [MyUser] = [
        MyUser(name:"ligy",children:[MyUser(name:"ligy_1", children: nil)])
    ]
}


struct ExpandListView: View {
    
    @ObserveInjection var inject
    @State var users:[String] = ["li","wang","shang","pan"]
    
    var body: some View {

        List(MyUser.default,children: \.children){ row in
            Text(row.name)
        }
        .enableInjection()
    }
}

struct ExpandListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandListView()
    }
}
