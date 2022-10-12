//
//  CustomTabView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/2.
//

import SwiftUI
import Inject


 

struct PaginationView<LoopPage: View>: View {

    @ObserveInjection var inject
    
    enum DragDirection : Int{
        case toTop = 1
        case toRight = 2
        case toBottom = 3
        case toLeft = 4
    }
    
    @GestureState var isDragging = false
    
    let minimumDistance : CGFloat
    let onSwipeChanging : ((_ width:CGFloat) -> Void)?
    let onDragChanged : ((_ isDragging:Bool) -> Void)?
    
    let loopPage : ((_ index : Int) -> LoopPage)

    @ObservedObject var pageModel : PageModel
    
    init(pageModel : PageModel,minimumDistance :CGFloat = 30.0
         , onSwipeChanging:((_ width:CGFloat) -> Void)? = nil
         , onDragChanged:((_ isDragging:Bool) -> Void)? = nil
         , @ViewBuilder loopPage : @escaping ((_ index : Int) -> LoopPage) ){
   
        
        let  appearance =  UINavigationBar.appearance()
        appearance.backgroundColor = .clear
        appearance.shadowImage = UIImage() //底部线条
    
        self.minimumDistance = minimumDistance
        
        self.onSwipeChanging = onSwipeChanging
        self.onDragChanged = onDragChanged
        self.loopPage = loopPage
        
        self.pageModel = pageModel
    }
    
    
    var draggesture : some Gesture{
        DragGesture(minimumDistance: minimumDistance,coordinateSpace: .global)
            .updating($isDragging){ _, state, _ in
                state = true
            }
            .onChanged { value in
                var toLeft = false
                if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                    toLeft = true
                }
                
                var toRight = false
                if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                    toRight  = true
                }
                
                let flag = (pageModel.activeIndex != 0 || toRight )
                && (pageModel.activeIndex != pageModel.total - 1 || toLeft)
 
                if flag {
                    pageModel.draggingOffset =  value.translation.width
                }
                
                onSwipeChanging?(value.translation.width)
            }
    }
    
    var body: some View {
        
        GeometryReader{ proxy in
            getMainContent(for: proxy.size)
        }
        .clipped()
        
        .enableInjection()
    }
    
    func getMainContent(for size : CGSize) -> AnyView{
        let stack = VStack{
            ZStack{
                ForEach(Array(pageModel.indexes.reversed()),id:\.self){  item in
                    if item < 0 || item >= pageModel.total{
                       EmptyView()
                    }
                    else{
                        loopPage(item)
                            .offset(x: calcOffset(item))
                            .tag(item)
                    }
                }
                .offset(x: pageModel.draggingOffset)
            }
        }
       let content :AnyView = AnyView(stack.contentShape(Rectangle()))
        
       return AnyView(
        content
         .gesture(draggesture)
         .onChange(of: isDragging) { _ in
             if !isDragging {
                 
                 //to right
                 if pageModel.draggingOffset < 0 {
                     if abs(pageModel.draggingOffset) > UIScreen.main.bounds.width / 2 * 0.7{
                         pageModel.goPage(pageModel.activeIndex + 1)
                     }
                     pageModel.resetDrag()
                 }
                 
                 //to left
                 if pageModel.draggingOffset > 0{
                     if abs(pageModel.draggingOffset) > UIScreen.main.bounds.width / 2 * 0.7{
                         pageModel.goPage(pageModel.activeIndex - 1)
                     }
                     pageModel.resetDrag()
                 }
             }
             onDragChanged?(isDragging)
         }
       )
    }

    func calcOffset(_ currentRow:Int) -> CGFloat{
        return  (currentRow - pageModel.activeIndex) < 0 ? -UIScreen.main.bounds.width : (currentRow - pageModel.activeIndex) > 0 ? UIScreen.main.bounds.width : 0
    }
}

struct CustomTabPreferenceKeyPreferenceData {
    let viewIdx: Int
    let bounds: Anchor<CGRect>
}

struct CustomTabPreferenceKey : PreferenceKey {
    
    typealias Value = [CustomTabPreferenceKeyPreferenceData]
    
    static var defaultValue: [CustomTabPreferenceKeyPreferenceData] = []
    
    static func reduce(value: inout [CustomTabPreferenceKeyPreferenceData], nextValue: () -> [CustomTabPreferenceKeyPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}



struct CustomTabPreferenceKeyPreferenceData2 {
    let viewIdx: Int
    let bounds: Anchor<CGRect>
}

struct CustomTabPreferenceKey2 : PreferenceKey {
    
    typealias Value = [CustomTabPreferenceKeyPreferenceData2]
    
    static var defaultValue: [CustomTabPreferenceKeyPreferenceData2] = []
    
    static func reduce(value: inout [CustomTabPreferenceKeyPreferenceData2], nextValue: () -> [CustomTabPreferenceKeyPreferenceData2]) {
        value.append(contentsOf: nextValue())
    }
}

