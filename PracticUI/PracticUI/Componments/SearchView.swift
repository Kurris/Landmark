//
//  SearchView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/13.
//

import SwiftUI
import Inject

struct SearchView: View {
    
    @ObserveInjection var inject
    @State var text = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model : Model
    
    var body: some View {
        NavigationView{
            List{
                ForEach(Travel.default.filter({ item in
                  return  item.title.contains(text) || text == ""
                })){ item in
                    Button {
                        text = item.title
                        presentationMode.wrappedValue.dismiss()
                        model.cardSelectedId = item.id
                        withAnimation(.toOpen.delay(0.1)) {
                            model.isShowCardDetail = true
                        }
                        
                    } label: {
                        HStack(){
                            Image(item.backgroundImage)
                                .resizable()
                                .aspectRatio( contentMode: ContentMode.fill)
                                .frame(width: 45, height: 45)
                                .padding(10)
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                HStack{
                                    Text(item.title)
                                        .foregroundColor(.black)
                                        .bold()
                                    
                                    Spacer()
                                    Text("作者:\(item.auther)")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                }
                                
                                Text(item.content).font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            } .searchable(text: $text , placement: .navigationBarDrawer(displayMode: .always), prompt: Text("请输入地点"))
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("完成")
                        }
                        
                    }
                }
        }
        .enableInjection()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
