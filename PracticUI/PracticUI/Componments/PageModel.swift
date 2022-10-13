//
//  Pager.swift
//  SwiftUIPager
//
//  Created by Fernando Moya de Rivas on 19/01/2020.
//  Copyright © 2020 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI
import Combine

/// Encapsulates `Pager` state.
///
/// Initialize with one of its convenience methods:
/// - `firstPage()`
/// - `withIndex(_:)`
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public class PageModel: ObservableObject {

//   Needed for `iOS 13` or else it won't trigger an update
//   public var objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var activeIndex: Int = 0

    @Published var indexes : [Int] = [0,1,2]
    
    @Published var total = 0
    
    var _isNativePage : Bool = false
    public var isNativePage : Bool {
        get{_isNativePage}
        set{
            _isNativePage = newValue
            draggingOffset = _isNativePage ? UIScreen.main.bounds.width : 0
            total = 1
        }
    }
    
   #if !os(tvOS)
    
    /// `swipeGesture` 当前拖动的值
    @Published var draggingOffset: CGFloat = 0.0

    /// `swipeGesture` 上一次拖动的值
    @Published var lastDraggingValue: CGFloat = 0.0
    
    /// `swipeGesture` 滑动速度
    var draggingVelocity: Double = 0


    #endif
    
    /// Increment resulting from the last swipe
    var pageIncrement = 0
  
    var isInfinite = false

    var lastDigitalCrownPageOffset: CGFloat = 0
    
    var name : String
    init(name: String , isNativePage : Bool = false){
        self.name = name
        self.isNativePage = isNativePage
    }
    
    public func goPage(_ pageIndex:Int){
        
        guard pageIndex >= 0 else {return}
        
        // to right
        if pageIndex - activeIndex > 1{
            indexes.remove(at: 2)
            indexes.append(pageIndex)
        }
        //to left
        else if pageIndex - activeIndex < -1{
            indexes.remove(at: 0)
            indexes.insert(pageIndex, at: 0)
        }
        else {
            withAnimation {
                indexes[0] = pageIndex - 1
                indexes[1] = pageIndex
                indexes[2] = pageIndex + 1
            }
            resetDrag()
        }
        
        withAnimation {
            activeIndex = pageIndex
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.indexes[0] = self.activeIndex - 1
            self.indexes[1] = self.activeIndex
            self.indexes[2] = self.activeIndex + 1
        }
    }
    
    public func resetDrag(){
        withAnimation {
            self.draggingOffset = 0.0
        }
    }
}
