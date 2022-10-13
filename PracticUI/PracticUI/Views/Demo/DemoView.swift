//
//  DemoView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/16.
//

import SwiftUI
import Inject
import Alamofire
import CodeScanner


struct DemoView: View {
    
    @ObserveInjection var inject
    
    @State var isShowPopover = false
    @State var isAlwaysShowPopover = false
    
    @State var isShowNoPaddingList = false
    
    @State var isFullScreen = false
    
    @EnvironmentObject var model : Model
    
    var body: some View {
        NavigationView{
            List{
                Section("App Interaction"){
                    
                    Button("Reload App"){
                        withAnimation {
                            model.isShowSplashPage = true
                        }
                    }
                    
                    JumpView {
                        AppStateView()
                    } label: {
                        Text("App State")
                    }
                    
                    JumpView {
                        DeviceRotationView()
                    } label: {
                        Text("App Rotation")
                    }
                    
                    JumpView {
                        ShakeView()
                    } label: {
                        Text("Device Shake")
                    }
                }
                
                Section(header:Text("Navigation")) {
                    JumpView {
                        DefaultTab()
                    } label: {
                        Image(systemName: "menucard")
                        Text("默认tab")
                    }
                    
                    
                    JumpView {
                        TabItemView().offset(y:-350)
                    } label: {
                        Text("自定义tab")
                    }
                    
                    JumpView {
                        NestedPageView()
                    } label: {
                        Text("嵌套分页")
                    }
                    
                    JumpView {
                        NativePageView()
                    } label: {
                        Text("原生分页")
                    }
                    
                    JumpView{
                        NavigationBar(title: "标题", hasScrolled: .constant(false))
                    } label:{
                        Text("自定义header")
                    }
                    
                    
                    JumpView{
                        CustomNavigation()
                            .navigationBarBackButtonHidden(true)
                    } label:{
                        Text("隐藏BackButton")
                    }
                }
                .listRowSeparatorTint(.blue)
                
                
                Section("Camera"){
                    JumpView{
                        ScanView()
                    }label: {
                        Text("扫码")
                    }
                    
                    
                    Text("全屏扫码").fullScreenCover(isPresented: $isFullScreen) {
                        ScanView()
                            .ignoresSafeArea()
                            .statusBar(hidden: true)
                            .frame(maxWidth:.infinity , maxHeight: .infinity)
                            .onDisappear{
                                UIView.setAnimationsEnabled(true)
                            }
                            .onTapGesture{
                                isFullScreen = false
                            }
                    }
                    .onTapGesture {
                        UIView.setAnimationsEnabled(false)
                        isFullScreen = true
                    }
                }
                
                
                Section("Keyboard"){
                    JumpView {
                        KeyboardAttachmentView()
                    } label: {
                        Text("自定义keyboard内容")
                    }
                }
                
                Section("Gesture"){
                    JumpView {
                        TapGestureView()
                    } label: {
                        Text("单击/双击...")
                    }
                    
                    JumpView {
                        LongPressGestureView()
                    } label: {
                        Text("长按")
                    }
                    
                    JumpView {
                        DragGestureView()
                    } label: {
                        Text("拖拽")
                    }
                    
                    JumpView {
                        HighPriorityGestureView()
                    } label: {
                        Text("高优先级,并且覆盖")
                    }
                    
                    JumpView {
                        SimultaneousGestureView()
                    } label: {
                        Text("同时触发")
                    }
                    
                    JumpView {
                        ChainsGestureView()
                    } label: {
                        Text("手势链路")
                    }
                }
                
                
                Group{
                    Section(header: Text("Popover")) {
                        
                        Button {
                            isShowPopover = true
                        } label: {
                            Text("显示默认Popover")
                        }.popover(isPresented: $isShowPopover) {
                            CodeScannerView(codeTypes: [.qr]) { response in
                                print(response)
                                switch response {
                                case .success(let result):
                                    print("Found code: \(result.string)")
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        }
                        
                        Button {
                            isAlwaysShowPopover = true
                        } label: {
                            Text("强制显示Popover")
                        }
                        .sheet(isPresented: $isAlwaysShowPopover) {
                            VStack{
                                Button {
                                    _ = Alert(title: Text("提醒"), message: Text("123"),dismissButton: .cancel())
                                } label: {
                                    Text("item")
                                }
                                
                                .interactiveDismissDisabled()
                            }
                        }
                        
                        
                        JumpView{
                            DifferentPopoverView()
                        }label: {
                            Text("不同的popover类型")
                        }
                    }
                    .listRowSeparator(.hidden)
                    
                    Section("Sticky") {
                        JumpView {
                            StickyView()
                        } label: {
                            Text("Sticky")
                        }
                        
                        JumpView {
                            MultiStickyView()
                        } label: {
                            Text("Multi Sticky")
                        }
                    }
                    
                    Link(destination: URL(string: "https://www.youtube.com/")!) {
                        HStack {
                            Label("Youtube", systemImage: "tv")
                            Spacer()
                            
                            Image(systemName: "link")
                                .foregroundColor(.secondary)
                        }
                    }
                    .listRowInsets(isShowNoPaddingList ? EdgeInsets() : .none)
                    
                    
                    Section("Progress") {
                        JumpView {
                            DefaultProgressView()
                        } label: {
                            Text("默认进度条")
                        }
                        
                        JumpView {
                            CustomProgressView()
                        } label: {
                            Text("自定义进度条")
                        }
                    }
                    
                    
                    Section("Timer"){
                        JumpView{
                            TimerView()
                        }label: {
                            Text("定时器使用")
                        }
                    }
                    
                    
                    Section("Components"){
                        JumpView {
                            PickerView()
                        } label: {
                            Text("Picker")
                        }
                        
                        
                        JumpView {
                            ToggleView()
                        } label: {
                            Text("Toggle")
                        }
                        
                        
                        JumpView {
                            DatePickerView()
                        } label: {
                            Text("DatePicker")
                        }
                        
                        JumpView {
                            SliderView()
                        } label: {
                            Text("Slider")
                        }
                        
                        
                        JumpView {
                            StepperView()
                        } label: {
                            Text("Stepper")
                        }
                        
                        JumpView {
                            MenuView()
                        } label: {
                            Text("Menu")
                        }
                        
                        JumpView {
                            ContextMenuView()
                        } label: {
                            Text("ContextMenu")
                        }
                        
                        JumpView {
                            MapView()
                        } label: {
                            Text("Map")
                        }
                    }
                    
                    Section("Notifications"){
                        JumpView {
                            NotificationView()
                        } label: {
                            Text("Notification")
                        }
                        
                        
                        JumpView {
                            AlertView()
                        } label: {
                            Text("Alert")
                        }
                        
                        JumpView {
                            ConfirmationDialogView()
                        } label: {
                            Text("ConfirmationDialog")
                        }
                        
                        JumpView{
                            ShakeFeedbackView()
                        }label: {
                            Text("Shake Feedback")
                        }
                    }
                    
                    
                    Section("List"){
                        JumpView {
                            DeleteAndEditListView()
                        } label: {
                            Text("Delete/Edit list")
                        }
                        
                        
                        JumpView {
                            SwipeListView()
                        } label: {
                            Text("Swipe list")
                        }
                        
                        
                        JumpView {
                            ExpandListView()
                        } label: {
                            Text("Expand list")
                        }
                        
                        JumpView {
                            ScrollListView()
                        } label: {
                            Text("Scroll list")
                        }
                        
                        JumpView {
                            RadiusListView()
                        } label: {
                            Text("Radius list")
                        }
                    }
                    
                    Section("Badge"){
                        JumpView {
                            DefaultBadgeView()
                        } label: {
                            Text("Default badge")
                        }
                        
                        JumpView {
                            BadgeInListView()
                        } label: {
                            Text("Badge in list")
                        }
                    }
                }
                
                Section("Custom Style"){
                    JumpView {
                        CheckToggleStyleView()
                    } label: {
                        Text("Toggle:CheckBox")
                    }
                    
                    JumpView {
                        TextFieldWithIconStyleView()
                    } label: {
                        Text("TextField:WithIcon")
                    }
                    
                    JumpView {
                        StrokeCornerRadiusStyleView()
                    } label: {
                        Text("Modifier:StrokeCornerRadius")
                    }
                }
                
                
                Section("Input"){
                    JumpView {
                        CustomSubmitButtonView()
                    } label: {
                        Text("自定义按钮")
                    }
                    
                    
                    JumpView {
                        OnSubmitView()
                    } label: {
                        Text("按钮触发动作")
                    }
                }
                
                Section("Geometry"){
                    JumpView{
                        MatchedGeometryEffectView()
                    }label: {
                        Text("几何匹配")
                    }
                    
                    
                    JumpView{
                        AnchorPreferenceView()
                    }label: {
                        Text("锚击位置")
                    }
                    
                    JumpView{
                        GeometryReaderView()
                    }label: {
                        Text("几何阅读")
                    }
                }
                
            }
            //.listStyle(.grouped)
            //.listStyle(.inset)
            .navigationTitle("Demo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Toggle("无边距样式", isOn: $isShowNoPaddingList)
                        .toggleStyle(.button)
                }
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 70)
            }
        }
        .enableInjection()
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
