//
//  ClosedScreen.swift
//  lynx
//
//  Created by Andrew Tran on 8/21/22.
//

import SwiftUI

struct ClosedScreen: View {
    var body: some View {
        VStack {
            TabView {
                GeometryReader { g in
                    VStack {
                        Image("closed")
                            .resizable()
                            .frame(width: 250, height: 250)
                            .scaledToFit()
                        Text("Come back tomorrow!")
                            .font(.title).bold()
                            .padding(.all, 20)
                        Text("Lynx will be temporarily under maintenance. Come back later!")
                            .multilineTextAlignment(.center)
                                .padding(.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/20)
                    }
                    .opacity(Double(g.frame(in : . global).minX)/200+1)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .background(Color(.white))
            
        }
    }
}

struct ClosedScreen_Previews: PreviewProvider {
    static var previews: some View {
        ClosedScreen()
    }
}
