//
//  UINavigationController.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/16.
//

import SwiftUI

///添加此代码,可以在 .navigationBarBackButtonHidden(true)后仍然可以使用手势返回
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
