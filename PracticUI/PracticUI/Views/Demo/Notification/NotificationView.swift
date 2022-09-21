//
//  NotificationView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/20.
//

import SwiftUI
import UserNotifications
import Inject

//询问用户是否允许该app推送通知
//由于推送系统中类型蛮多的，可以自己去“设置”中研究一下。这里的.alert表示是否允许弹窗； .sound表示是否允许提示音；.badge表示通知弹窗中的那个小图。
func setNotification(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (granted, _) in
        if granted {
            //用户同意我们推送通知
            print("用户同意我们推送通知")
        }else{
            //用户不同意
            print("用户不同意")
        }
    }
}

//推送通知
func makeNotification(){
    
      let date = Date()
    
    var dateComponents = DateComponents()
    dateComponents.hour = Calendar.current.component(.hour, from: date)
    dateComponents.minute = Calendar.current.component(.minute, from: date)
    dateComponents.second = Calendar.current.component(.second, from: date) + 10
    
    
    //设置通知的触发器：10秒后触发推送（这种通知推送不能重复）
    //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    //通知的内容
    let content = UNMutableNotificationContent()
    content.title = "通知的标题"
    content.body = "通知的内容"
    /* 通知提示音，default是“叮～”，就是短信的提示音。还有个defaultCritical，就是一般app推送通知的声音 */
    content.sound = UNNotificationSound.default
    
    //完成通知的设置
    let request = UNNotificationRequest(identifier: "通知名称", content: content, trigger: trigger)
    //添加我们的通知到UNUserNotificationCenter推送的队列里
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}


struct NotificationView: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        VStack {
            Button(action: {
                setNotification()
            }) {
                Text("获取推送权限")
                    .padding()
            }
            Button(action: {
                makeNotification()
            }) {
                Text("推送通知")
                    .padding()
            }
        }
        .enableInjection()
    }
}
