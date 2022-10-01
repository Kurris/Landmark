//
//  AccountView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/21.
//

import SwiftUI
import Alamofire
import Inject

struct AccountView: View {
    
    @State private var isDeleted = false
    @State private var isPinned = false
    
    @State var isFullscreenScan = false
    
    @State private var coins: [Coin] = []
    
    @ObserveInjection var inject
    
    var body: some View {
        NavigationView {
            List {
                
                profileView
                
                menus
                
                links
                
                Section(header: Text("coins")) {
                    if coins.count > 0 {
                        ForEach(coins) { coin in
                            HStack {
                                AsyncImage(url: URL(string: coin.logo)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 28, height: 28, alignment: .leading)
                                .padding(.trailing, 10)
                                
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(coin.coin_name)
                                    
                                    Text(coin.acronym)
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    } else {
                        ForEach(0..<10) { item in
                            Text("")
                                .frame(maxWidth: .infinity)
                        }
                        .redacted(reason: coins.count == 0 ? .placeholder : [])
                    }
                }
                  
                Section{
                    HStack{
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("切换账号")
                        }
                        
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("退出登陆")
                                .foregroundColor(.red)
                        }
                        
                        Spacer()
                    }
                    //.listRowBackground(Color.red)
                }
            }
            .listStyle(.automatic)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement:  .navigationBarTrailing) {
                    
                    
                    Image(systemName: "qrcode.viewfinder").foregroundColor(.black)
                        .fullScreenCover(isPresented: $isFullscreenScan) {
                        ScanView()
                    }
                    .onTapGesture {
                        
                        isFullscreenScan = true
                    }
                }
            }
            .refreshable {
                await  getCoinsAsync()
            }
            .task {
                await  getCoinsAsync()
            }
        }
        .enableInjection()
    }
    
    func getCoinsAsync() async {
        let url = "https://random-data-api.com/api/crypto_coin/random_crypto_coin?size=10"
        
        AF.request(url).responseDecodable { (response: AFDataResponse<Array<Coin>>) in
            switch response.result {
            case .success(let models):
                coins = models
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var profileView: some View {
        VStack(spacing: 8) {
            ZStack {
                DynamicPicView()
                    .frame(width: 200, height: 130)
                    .rotationEffect(Angle(radians: -90))
                    .offset(x: 142, y: -10)

                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                    .symbolVariant(.circle.fill)
                    .font(.system(size: 32))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.green, .blue.opacity(0.5))
                    .padding()
                    .background(Circle().fill(.ultraThinMaterial))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            HStack {
                
                Image(systemName: "location")
                    .imageScale(.small)
                Text("China")
                    .foregroundColor(.secondary)
                
                Text("Ligy")
                    .font(.title)
                    .bold()
            }
        }
    }
    
    var menus: some View {
        Section {
            NavigationLink(destination: CanvasView()) {
                Label("settings", systemImage: "gear")
            }
            
            NavigationLink() {
                ExploreView()
            } label: {
                Label("help", systemImage: "questionmark")
            }
        }
        //.listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
    
    var links: some View {
        Section(header: Text("External Links")) {
            
            if !isDeleted {
                Link(destination: URL(string: "https://www.apple.com.cn/")!) {
                    HStack {
                        Label("Apple", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                }
                .swipeActions(allowsFullSwipe: false) {
                    Button(action: {
                        isDeleted = true
                    }) {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                    pinButton
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
            .swipeActions(allowsFullSwipe: false) {
                pinButton
            }
            
            
            Link(destination: URL(string: "https://isawesome.cn")!) {
                HStack {
                    Label("我的主页", systemImage: "house")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundColor(.secondary)
                }
            }
        }
        .accentColor(.primary)
    }
    
    
    var pinButton: some View {
        Button {
            isPinned.toggle()
        } label: {
            if isPinned {
                Label("Pin", systemImage: "pin.slash")
            } else {
                Label("UnPin", systemImage: "pin")
            }
            
        }
        .tint(isPinned ? .gray : .yellow)
    }
}

