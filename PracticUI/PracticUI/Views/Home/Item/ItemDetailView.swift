//
//  ItemDetailView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/24.
//

import SwiftUI
import Inject

struct ItemDetailView: View {
    @ObserveInjection var inject
    var namespace: Namespace.ID
    var travel: Travel
    
    @State var elementAppear: [Bool] = [false, false, false]
    @EnvironmentObject var model : Model
    @State var viewState:CGSize = .zero
    @State var isDraggable = true
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content.offset(y: 100)
            }
            .background(.white)
            .mask(RoundedRectangle(cornerRadius: 30 ,style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
            .scaleEffect(1 + -viewState.width/500)
            .background(.black.opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()
            .statusBar(hidden: model.isShowCardDetail)
            
        }
        .onAppear {
            fadeIn()
        }
        .onChange(of: model.isShowCardDetail) { newValue in
            fadeOut()
        }
        .enableInjection()
    }
    
    
    var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(travel.contentTitle)
                .font(.title2.bold())
            
            Text(travel.content)
                .lineSpacing(10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .padding(.bottom, 200)
        .opacity(elementAppear[2] ? 1 : 0)
    }
    
    var drag : some Gesture{
        DragGesture(minimumDistance: 30, coordinateSpace: .local).onChanged({ value in
            guard value.translation.width > 0 else { return }

            if value.startLocation.x < 100 {
                withAnimation(.toClose) {
                    viewState = value.translation
                }
            }
            if viewState.width >= UIScreen.main.bounds.width/4{
                close()
            }
        }).onEnded({ value in
            if viewState.width >= UIScreen.main.bounds.width/4{
                close()
            }else{
                withAnimation(.toClose){
                    viewState = .zero
                }
            }
        })
    }
    
    
    func fadeIn() {
        withAnimation(.easeInOut(duration: 0.3).delay(0.2)) {
            elementAppear[0] = true
        }
        
        withAnimation(.easeInOut(duration: 0.2).delay(0.3)) {
            elementAppear[1] = true
        }
        
        withAnimation(.easeInOut(duration: 0.2).delay(0.4)) {
            elementAppear[2] = true
        }
    }
    
    func fadeOut() {
        elementAppear[0] = false
        elementAppear[1] = false
        elementAppear[2] = false
    }
    
    var cover: some View {
        GeometryReader{ proxy in
            let scrollY = proxy.frame(in: .global).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(height: 500 + scrollY)
            .background {
                Image(travel.backgroundImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(travel.id)", in: namespace)
                    .offset(y: -scrollY)
                    .blur(radius: scrollY / 20)
                
                closeButton
                    .opacity(1.0 + -viewState.width * 0.01)
                    .padding(20)
                    .offset(x:10)
            }
            .mask {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(travel.id)", in: namespace)
                    .offset(y: -scrollY)
            }
            .overlay {
                overlayContent
                    .offset(y: -scrollY * 0.6)
            }
        }
        .frame(height:500)
    }
    
    var overlayContent : some View{
        VStack(alignment: .leading, spacing: 12) {
            
            Text(travel.title)
                .font(.largeTitle).bold()
                .matchedGeometryEffect(id: "title\(travel.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(travel.subTitle)
                .matchedGeometryEffect(id: "subTitle\(travel.id)", in: namespace)
            
            Divider()
                .opacity(elementAppear[0] ? 1 : 0)
            
            HStack {
                Image(systemName: "person.crop.circle")
                    .frame(width: 32, height: 32)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .strokeCornerRadiusStyle(cornerRadius: 18)
                
                Text("作者: \(travel.auther)")
                    .font(.footnote)
            }
            .opacity(elementAppear[1] ? 1 : 0)
        }
        .padding(20)
        .background {
            Rectangle().fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .matchedGeometryEffect(id: "blur\(travel.id)", in: namespace)
                .blur(radius: 0.7)
        }
        .offset(y: 250)
        .padding(20)
    }
    
    var closeButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                model.isShowCardDetail.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
    }
    
    func close(){
        withAnimation(.toClose) {
            model.isShowCardDetail.toggle()
        }
        
        withAnimation (.toClose){
            viewState = .zero
        }
        
        isDraggable = false
    }
}


struct ItemDetailView_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        ItemDetailView(namespace: namespace, travel: Travel.default[0])
    }
}
