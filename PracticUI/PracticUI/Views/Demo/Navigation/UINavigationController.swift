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

//extension HomeViewController {
//    private func setupNavigationBar(){
//             /***
//             设置导航栏颜色
//             ***/
//            //设置导航栏背景颜色
//            navigationController?.navigationBar.barTintColor = UIColor.red
//            //设置Navigationbar背景全透明效果
//            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//            self.navigationController?.navigationBar.shadowImage = UIImage()
//            self.navigationController?.navigationBar.isTranslucent = true
//
//            /***
//             设置导航栏title
//             ***/
//            //设置导航栏title
//            self.title = "网易新闻"
//            // 自定义view设置title
//            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//            titleLabel.text = "网易新闻"
//            titleLabel.textColor = UIColor.white
//            navigationItem.titleView = titleLabel
//            // 图片
//            let imageView = UIImageView(image: UIImage(named : "contentview_imagebg_logo"))
//            navigationItem.titleView = imageView
//
//            /***
//             设置导航栏左右按钮
//             ***/
//            //文字
//            let leftBarButtonItem = UIBarButtonItem(title: "leftButton", style: .plain, target: self, action: #selector(self.leftClick))
//            let rightBarButtonItem = UIBarButtonItem(title: "rightButton", style: .plain, target: self, action: #selector(self.rightClick))
//
//            navigationItem.leftBarButtonItem = leftBarButtonItem
//            navigationItem.rightBarButtonItem = rightBarButtonItem
//            // 图片
//            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "fog"), style: .plain, target: self, action: #selector(self.leftClick))
//            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "fog"), style: .plain, target: self, action: #selector(self.rightClick))
//            // 自定义
//            let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//            let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//            leftButton.setTitleColor(UIColor.black, for: UIControlState.normal)
//            rightButton.setTitleColor(UIColor.black, for: UIControlState.normal)
//            leftButton.setTitle("leftButton", for: UIControlState.normal)
//            rightButton.setTitle("rightButton", for: UIControlState.normal)
//            leftButton.addTarget(self, action: #selector(leftClick), for: UIControlEvents.touchUpInside)
//            rightButton.addTarget(self, action: #selector(rightClick), for: UIControlEvents.touchUpInside)
//            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
//            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
//            // BarButtonItem颜色
//            leftBarButtonItem.tintColor = UIColor.black
//
//        }
//
//        @objc private func leftClick() {
//            print("leftClick")
//        }
//
//        @objc private func rightClick() {
//            print("rightClick")
//        }
//    }
//}
