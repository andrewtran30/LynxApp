//
//  ContentView.swift
//  lynx
//
//  Created by Arnav Wadehra on 6/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: MainViewModel

    var body: some View {
        if (viewModel.userSession == nil) {
            SignInView()
        } else {
            if let user = viewModel.currentUser {
                if(viewModel.appOn){
                MainTabView(user: user)
                }
                else {
                    ClosedScreen()
                }

            }
        }
    }
}
