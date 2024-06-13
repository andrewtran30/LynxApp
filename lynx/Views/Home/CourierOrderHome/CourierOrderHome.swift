//
//  CourierOrderHome.swift
//  lynx
//
//  Created by Jeremy Suh on 7/10/22.
//

import SwiftUI
import UIKit
import CoreData

struct CourierOrderHome: View {
    let user: User
    @ObservedObject var viewModel = CourierHomeViewModel()
    
    @ObservedObject var viewModel2 = HomeViewModel()
    @State private var searchText = ""
    @Binding var selectedTab: MainTabView.Tab
    
    var body: some View {
        ScrollView {
            VStack {
                if (viewModel.orderBuckets.count > 0) {
                    ForEach(searchResults) { bucket in
                        OrderBucketCardView(orderBucket: bucket, selectedTab: $selectedTab)
                    }
                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by Dropoff Location")
                    .navigationTitle("Take an Order")
                    .toolbar {
                        Button(action: {
                            viewModel.fetchOrderBuckets()
                            viewModel2.fetchRestaurants()
                            viewModel2.fetchBuckets()
                            viewModel2.filterOrders()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                        })
                    }
                } else {
                    Text("There are no current active orders. Come back later!")
                        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by Dropoff Location")
                        .toolbar {
                        Button(action: {
                            viewModel.fetchOrderBuckets()
                            viewModel2.fetchRestaurants()
                            viewModel2.fetchBuckets()
                            viewModel2.filterOrders()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                        })
                    }
                }
                
            }.padding(.top, 5)
        }.onAppear {
            viewModel.fetchOrderBuckets()
            viewModel2.fetchRestaurants()
            viewModel2.fetchBuckets()
            viewModel2.filterOrders()
        }
    }
    
    var searchResults: [OrderBucket] {
        if searchText.isEmpty {
            return viewModel.orderBuckets
        }
        else {
            return viewModel.orderBuckets.filter { $0.destination.localizedCaseInsensitiveContains(searchText) }
        }
    }
}


