//
//  HomeView.swift
//  lynx
//
//  Created by Arnav Wadehra on 6/14/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct HomeView: View {
    let user: User
    let deliveryAddress: String
    let location: Location
    @State var startOrder = true
    @ObservedObject var viewModel = HomeViewModel()
    @State private var searchText = ""
    @Binding var selectedTab: MainTabView.Tab
    
    var body: some View {
        ScrollView{
            
        VStack{
            Divider()
            Spacer().frame(height: 10)

            ForEach(searchResults) { orderBucket in
                CurrentOrderCell(selectedTab: $selectedTab, orderBucket: orderBucket, user: user, location: location)

            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Restaurants")
            .navigationTitle("Existing Orders")
            .toolbar{
                    Button(action: {
                        viewModel.fetchRestaurants()
                        viewModel.fetchBuckets()
                        viewModel.filterOrders()
                        
                    }, label: {
                        Image(systemName: "arrow.clockwise") .font(.system(size: 12))
                })
            }
            .background(Color.white)
          
            NavigationLink {
                ChooseOrderView(user: user, viewModel: viewModel, deliveryDestination: deliveryAddress, location: location, selectedTab: $selectedTab)
            } label: {
                Text("Create a new order")
                    .font(.custom("Avenir", size: 19))
                    .bold()
                    .frame(width: UIScreen.main.bounds.width - 30, height: 40)
                    .foregroundColor(Color.white)
                    .background(Color(hex: "E4AA15")
                        .opacity(0.8))
                    .cornerRadius(20)
            }
            Spacer()
            }
        }
    }
    
    var searchResults: [OrderBucket] {
        if searchText.isEmpty {
            return viewModel.activeOrders
        }
        else {
            return viewModel.activeOrders.filter { $0.restaurantName.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
    


