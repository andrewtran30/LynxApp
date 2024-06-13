//
//  ChooseOrderView.swift
//  lynx
//
//  Created by Jeremy Suh on 6/27/22.
//

import SwiftUI

struct ChooseOrderView: View {
    let user: User
    @ObservedObject var viewModel: HomeViewModel
    @State var searchText = ""
    let deliveryDestination: String
    let location: Location
    @Binding var selectedTab: MainTabView.Tab
    
    var body: some View {
        ScrollView {
            VStack {
                Divider()
                    .background(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                // For each restaurant Card model to produce a bunch of these
                    ForEach(searchResults){ restaurant in
                        NavigationLink {
                            StartOrderView(deliveryDestination: deliveryDestination, user: user, restaurant: restaurant, location1: location, selectedTab: $selectedTab)
                        } label: {
                            RestaurantCardView(restaurantName: restaurant.restaurantName, restaurantLogo: restaurant.restaurantLogo)
                        }
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                    .navigationTitle("Restaurants")
            }
        }
    }
    
    var searchResults: [Restaurant] {
        if searchText.isEmpty {
            return viewModel.restaurants
        }
        else {
            return viewModel.restaurants.filter { $0.restaurantName.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

