//
//  OrderView.swift
//  lynx
//
//  Created by Arnav Wadehra on 6/14/22.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var viewModel = CurrentOrderViewModel()
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    Text("Orders")
                        .font(.custom("Avenir", size: 45))
                        .fontWeight(.heavy)
                        .frame(width: UIScreen.main.bounds.width * 0.75, alignment: .leading)
                        .padding(.leading, 15)
                        .padding(.top, 15)
                    Button(action: { viewModel.fetchOrder() }, label: {
                        Image(systemName: "arrow.clockwise")
                    })
                }
                
                Divider()
                    .background(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 5)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                    }
                    ScrollView {
                        ForEach(viewModel.order) { order in
                            OrderCardView(order: order)
                        }
                        // For each OrderCellModel --> produce all of them
                    }.frame(width: UIScreen.main.bounds.width)
                }
    }
}
