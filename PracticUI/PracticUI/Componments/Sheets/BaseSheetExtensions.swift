//
//  BaseSheetExtensions.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/2.
//

import SwiftUI

extension View {
    func halfSheet<Content:View,Title:View>(isShow: Binding<Bool>,heigh:CGFloat = UIScreen.main.bounds.height / 2, draggable:Bool,isShowCloseButton:Bool ,@ViewBuilder content:@escaping ()->Content,@ViewBuilder title:@escaping ()->Title) -> some View {
        modifier(BaseSheet(isShow: isShow, content: content, title: title, heigh: heigh, draggable: draggable, isShowCloseButton: isShowCloseButton))
    }
    
    func quarterSheet<Content:View,Title:View>(isShow: Binding<Bool>,heigh:CGFloat = UIScreen.main.bounds.height / 3, draggable:Bool,isShowCloseButton:Bool ,@ViewBuilder content:@escaping ()->Content,@ViewBuilder title:@escaping ()->Title) -> some View {
        modifier(BaseSheet(isShow: isShow, content: content, title: title, heigh: heigh, draggable: draggable, isShowCloseButton: isShowCloseButton))
    }
    
    
    func highSheet<Content:View,Title:View>(isShow: Binding<Bool>,heigh:CGFloat = UIScreen.main.bounds.height / 4 + UIScreen.main.bounds.height / 2 + UIScreen.main.bounds.height / 5 * 0.7, draggable:Bool,isShowCloseButton:Bool ,@ViewBuilder content:@escaping ()->Content,@ViewBuilder title:@escaping ()->Title) -> some View {
        modifier(BaseSheet(isShow: isShow, content: content, title: title, heigh: heigh, draggable: draggable, isShowCloseButton: isShowCloseButton))
    }
}
