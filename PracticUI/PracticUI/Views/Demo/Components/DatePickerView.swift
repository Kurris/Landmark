//
//  DatePicker.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/20.
//

import SwiftUI
import Inject

struct DatePickerView: View {
    
    @ObserveInjection var inject
    @State var selectedDate = Date()
    
    var body: some View {
        ScrollView{
            DatePicker("选择日期", selection: $selectedDate)
            
            //Date().addingTimeInterval(<#T##timeInterval: TimeInterval##TimeInterval#>)
            //从今天起,一共7天
            DatePicker("选择日期", selection: $selectedDate,in: Date()...Date(timeInterval: 6*23*3600, since: Date()))
            
            
            DatePicker("选择日期", selection: $selectedDate)
                .labelsHidden()
            
            //只能选择日期
            DatePicker("选择日期", selection: $selectedDate,displayedComponents: .date)
                
            
            DatePicker("选择日期graphical", selection: $selectedDate)
                .datePickerStyle(.graphical)
                
            
            DatePicker("选择日期wheel", selection: $selectedDate)
                .datePickerStyle(.wheel)
        }
    }
}
