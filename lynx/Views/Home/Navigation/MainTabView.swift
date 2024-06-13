//
//  MainTabView.swift
//  lynx
//
//  Created by Jeremy Suh on 6/23/22.
//

import Foundation

import SwiftUI

struct MainTabView: View {
  
    
    @EnvironmentObject var viewModel: MainViewModel
    @EnvironmentObject var appState: AppState
    @State private var selectedTab = Tab.home
    @StateObject private var vm = LocationsViewModel()
    @SceneStorage("courier") var courier: Bool = false
    let user: User
    
    enum Tab: Int {
        case home, orders, profile
    }
    
    func tabbarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large).foregroundColor(.white).background(Color.black)
            Text(text).foregroundColor(.white).background(Color.black)
        }
    }
    
    init(user: User) {
        self.user = user
        UITabBar.appearance().backgroundColor = UIColor.white
        

    }
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView{
                if(courier) {
                    CourierOrderHome(user: user, selectedTab: $selectedTab).navigationBarTitle(Text(""), displayMode: .inline)
                } else {
                    SetDeliveryView(user: user, selectedTab: $selectedTab).navigationBarTitle(Text(""), displayMode: .inline)
                        .environmentObject(vm)
                        .id(appState.rootViewId)
                }
            }.tabItem {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                }
            }.tag(Tab.home)
            
            NavigationView{
                if(courier) {
                    CourierOrderView().navigationBarTitle(Text(""), displayMode: .inline)
                } else {
                OrderView().navigationBarTitle(Text(""), displayMode: .inline)
                }
                
            }.tabItem {
                VStack {
                    Image(systemName: "bag")
                    Text("Orders")
                }
            }.tag(Tab.orders)
            
            NavigationView{ProfileView(user: user, courier: $courier).navigationBarTitle(Text(""), displayMode: .inline)}.tabItem {
                VStack {
                    Image(systemName: "person")
                    Text("Profile")
                }
            }.tag(Tab.profile)
        }.accentColor(Color("lynxPurple"))
    }
}


