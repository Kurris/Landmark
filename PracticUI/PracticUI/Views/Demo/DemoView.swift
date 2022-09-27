//
//  DemoView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/16.
//

import SwiftUI
import Inject
import Alamofire


struct DemoView: View {
    
    @ObserveInjection var inject
    
    @State var isShowPopover = false
    @State var isAlwaysShowPopover = false
    
    @State var isShowNoPaddingList = false
    
    
    var body: some View {
            NavigationView{
                List{

                    Section("App Interaction"){
//                        NavigationLink {
//                            AppStateView()
//                        } label: {
//                            Text("App State")
//                        }

                        JumpView {
                            AppStateView()
                        } label: {
                            Text("App State")
                        }
                        
                        NavigationLink {
                            DeviceRotationView()
                        } label: {
                            Text("App Rotation")
                        }
                    }


                    Section("Keyboard"){
                        NavigationLink {
                            KeyboardAttachmentView()
                        } label: {
                            Text("自定义keyboard内容")
                        }
                    }

                    Section("Gesture"){
                        NavigationLink {
                            TapGestureView()
                        } label: {
                            Text("单击/双击...")
                        }

                        NavigationLink {
                            LongPressGestureView()
                        } label: {
                            Text("长按")
                        }

                        NavigationLink {
                            DragGestureView()
                        } label: {
                            Text("拖拽")
                        }

                        NavigationLink {
                            HighPriorityGestureView()
                        } label: {
                            Text("高优先级,并且覆盖")
                        }

                        NavigationLink {
                            SimultaneousGestureView()
                        } label: {
                            Text("同时触发")
                        }

                        NavigationLink {
                            ChainsGestureView()
                        } label: {
                            Text("手势链路")
                        }
                    }


                    Group{
                        Section(header:Text("Navigation")) {
                            NavigationLink {
                                DefaultTab()
                            } label: {
                                Image(systemName: "menucard")
                                Text("默认tab")
                            }


                            NavigationLink {
                                TabItemView().offset(y:-350)
                            } label: {
                                Image(systemName: "menucard")
                                Text("自定义tab")
                            }

                            NavigationLink{
                                NavigationBar(title: "标题", hasScrolled: .constant(false))
                            } label:{
                                Text("自定义header")
                            }


                            NavigationLink{
                                CustomNavigation()
                                    .navigationBarBackButtonHidden(true)
                            } label:{
                                Text("隐藏BackButton")
                            }
                        }
                        .listRowSeparatorTint(.blue)


                        Section(header: Text("Popover")) {

                            Button {
                                isShowPopover = true
                            } label: {
                                Text("显示默认Popover")
                            }.popover(isPresented: $isShowPopover) {

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
                        }
                        .listRowSeparator(.hidden)

                        Section("Sticky") {
                            NavigationLink {
                                StickyView()
                            } label: {
                                Text("Sticky")
                            }

                            NavigationLink {
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
                            NavigationLink {
                                DefaultProgressView()
                            } label: {
                                Text("默认进度条")
                            }

                            NavigationLink {
                                CustomProgressView()
                            } label: {
                                Text("自定义进度条")
                            }
                        }


                        Section("Timer"){
                            NavigationLink{
                                TimerView()
                            }label: {
                                Text("定时器使用")
                            }
                        }


                        Section("Components"){
                            NavigationLink {
                                PickerView()
                            } label: {
                                Text("Picker")
                            }


                            NavigationLink {
                                ToggleView()
                            } label: {
                                Text("Toggle")
                            }


                            NavigationLink {
                                DatePickerView()
                            } label: {
                                Text("DatePicker")
                            }

                            NavigationLink {
                                SliderView()
                            } label: {
                                Text("Slider")
                            }


                            NavigationLink {
                                StepperView()
                            } label: {
                                Text("Stepper")
                            }

                            NavigationLink {
                                MenuView()
                            } label: {
                                Text("Menu")
                            }

                            NavigationLink {
                                ContextMenuView()
                            } label: {
                                Text("ContextMenu")
                            }
                        }

                        Section("Notifications"){
                            NavigationLink {
                                NotificationView()
                            } label: {
                                Text("Notification")
                            }


                            NavigationLink {
                                AlertView()
                            } label: {
                                Text("Alert")
                            }

                            NavigationLink {
                                ConfirmationDialogView()
                            } label: {
                                Text("ConfirmationDialog")
                            }
                        }


                        Section("List"){
                            NavigationLink {
                                DeleteAndEditListView()
                            } label: {
                                Text("Delete/Edit list")
                            }


                            NavigationLink {
                                SwipeListView()
                            } label: {
                                Text("Swipe list")
                            }


                            NavigationLink {
                                ExpandListView()
                            } label: {
                                Text("Expand list")
                            }

                            NavigationLink {
                                ScrollListView()
                            } label: {
                                Text("Scroll list")
                            }

                            NavigationLink {
                                RadiusListView()
                            } label: {
                                Text("Radius list")
                            }
                        }

                        Section("Badge"){
                            NavigationLink {
                                DefaultBadgeView()
                            } label: {
                                Text("Default badge")
                            }

                            NavigationLink {
                                BadgeInListView()
                            } label: {
                                Text("Badge in list")
                            }
                        }
                    }

                    Section("Custom Style"){
                        NavigationLink {
                            CheckToggleStyleView()
                        } label: {
                            Text("Toggle:CheckBox")
                        }

                        NavigationLink {
                            TextFieldWithIconStyleView()
                        } label: {
                            Text("TextField:WithIcon")
                        }

                        NavigationLink {
                            StrokeCornerRadiusStyleView()
                        } label: {
                            Text("Modifier:StrokeCornerRadius")
                        }
                    }


                    Section("Input"){
                        NavigationLink {
                            CustomSubmitButtonView()
                        } label: {
                            Text("自定义按钮")
                        }


                        NavigationLink {
                            OnSubmitView()
                        } label: {
                            Text("按钮触发动作")
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
