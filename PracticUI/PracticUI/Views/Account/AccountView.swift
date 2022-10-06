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
    
    @ObserveInjection var inject
    
    @State private var isDeleted = false
    @State private var isPinned = false
    
    @State var isFullscreenScan = false
    
    @State private var coins: [Coin] = []
    
    @EnvironmentObject var model : Model
    @State private var userInfo : UserInfo?
    @AppStorage("access_token") var accessToken : String?
    
    var body: some View {
        NavigationView {
            List {
                profileView
                if accessToken != nil && !accessToken!.isEmpty{
                   
                    
    //                menus
                    
                    links
                    
                    byteCoins
      
                   
                }
                
                Section{
//                    HStack{
//                        Spacer()
//                        Button {
//
//                        } label: {
//                            Text("切换账号")
//                        }
//
//                        Spacer()
//                    }
                    
                    HStack{
                        Spacer()
                        
                        if accessToken != nil && !accessToken!.isEmpty {
                            Button {
                                accessToken = nil
                                userInfo = nil
                            } label: {
                                Text("退出登陆").foregroundColor(.red)
                            }
                        }
                        else{
                            Button {
                                model.isShowLoginModal = true
                            } label: {
                                Text("登陆")
                            }
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
                await getUserInfoAsync()
            }
            .task {
                await  getCoinsAsync()
                await getUserInfoAsync()
            }
            .onChange(of: model.isShowLoginModal) { _ in
                if !model.isShowLoginModal && accessToken != nil && !accessToken!.isEmpty {
                    Task{
                        await  getCoinsAsync()
                        await getUserInfoAsync()
                    }
                }
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
    
    func getUserInfoAsync() async{
        let url = "https://isawesome.cn:5000/connect/userinfo";
        
        if accessToken != nil {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken!)",
            ]

            AF.request(url,method: .post,headers: headers).responseDecodable { (response: AFDataResponse<UserInfo>) in
                switch response.result {
                case .success(let userinfo):
                    userInfo = userinfo
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    var byteCoins : some View{
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
    }
    
    var profileView: some View {
        VStack(spacing: 8) {
            ZStack {
                DynamicPicView()
                    .frame(width: 200, height: 130)
                    .rotationEffect(Angle(radians: -90))
                    .offset(x: 142, y: -10)

                 if userInfo != nil{
                     AsyncImage(url: URL(string: userInfo!.picture)){ image in
                         
                         Circle().fill(.ultraThinMaterial)
                             .frame(width: 100, height: 100)
                             .overlay{
                                 image.resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 64, height: 64)
                                     .mask {
                                         Circle()
                                     }
                             }
                         
                         
                         Color.white.overlay{
                             Image(systemName: "checkmark")
                                 .symbolVariant(.circle.fill)
                                 .foregroundColor(.green)
                                 .font(.system(size: 20))
                         }
                         .frame(width: 20, height: 20)
                         .offset(x: -25, y: 20)
                         
                     } placeholder: {
                         ProgressView()
                     }
                 }else{
                     Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                         .symbolVariant(.circle.fill)
                                         .font(.system(size: 32))
                                         .symbolRenderingMode(.palette)
                                         .foregroundStyle(.green, .blue.opacity(0.5))
                                         .padding()
                                         .background(Circle().fill(.ultraThinMaterial))
                 }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack {
                
                Image(systemName: "location")
                    .imageScale(.small)
                Text("China")
                    .foregroundColor(.secondary)
                
                if userInfo != nil{
//                    Text(userInfo!.family_name).bold()
//                    + Text(userInfo!.given_name).bold()
                    
                    Text(userInfo!.name).bold()
                }
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
            
//            if !isDeleted {
//                Link(destination: URL(string: "https://www.apple.com.cn/")!) {
//                    HStack {
//                        Label("Apple", systemImage: "house")
//                        Spacer()
//                        Image(systemName: "link")
//                            .foregroundColor(.secondary)
//                    }
//                }
//                .onTapGesture{
//
//                }
//                .swipeActions(allowsFullSwipe: false) {
//                    Button(action: {
//                        isDeleted = true
//                    }) {
//                        Label("Delete", systemImage: "trash")
//                    }
//                    .tint(.red)
//                    pinButton
//                }
//            }
//
//
//            Link(destination: URL(string: "https://www.youtube.com/")!) {
//                HStack {
//                    Label("Youtube", systemImage: "tv")
//                    Spacer()
//                    Image(systemName: "link")
//                        .foregroundColor(.secondary)
//                }
//            }
//            .swipeActions(allowsFullSwipe: false) {
//                pinButton
//            }
            
            
            if userInfo?.website != nil && !userInfo!.website.isEmpty{
                Link(destination: URL(string: userInfo!.website)!) {
                    HStack {
                        Label("我的主页", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
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

