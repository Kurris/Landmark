//
//  MatchedGeometryEffectView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/28.
//

import SwiftUI
import Inject

struct MatchedGeometryEffectView: View {
    
    @ObserveInjection var inject
    
    @State var isShow = false
    @Namespace var namespace
    
    var body: some View {
        ZStack(alignment: .top){
           
            if isShow {
                VStack{
                    Text("只因世界")
                        .bold()
                        .foregroundColor(.blue)
                        .matchedGeometryEffect(id: "text", in: namespace)
                        .onTapGesture {
                            withAnimation {
                                isShow.toggle()
                            }
                        }
                       
                  
                    
                    VStack{
                        
                        Text("🐔你太美")
                            .matchedGeometryEffect(id: "ji", in: namespace)
                
                    }
                    
                    Spacer()
                }
                
            }else {
                VStack{
                    Spacer()
                    VStack{
                        
                        Text("🐔你太美")
                            .bold()
                            .matchedGeometryEffect(id: "ji", in: namespace)
                    }
                    
                    Text("只因世界")
                        .foregroundColor(.red)
                        .matchedGeometryEffect(id: "text", in: namespace)
                        .onTapGesture {
                            withAnimation {
                                isShow.toggle()
                            }
                        }
                    Spacer()
                }
               
            }
        }
        .frame(maxWidth:.infinity , maxHeight: .infinity)
        .enableInjection()
    }
}

struct MatchedGeometryEffectView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectView()
    }
}
