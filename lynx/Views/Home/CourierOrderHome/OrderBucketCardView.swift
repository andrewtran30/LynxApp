//
//  OrderBucketCardView.swift
//  lynx
//
//  Created by Jeremy Suh on 7/10/22.
//


import SwiftUI

struct OrderBucketCardView: View {
    let orderBucket: OrderBucket
    @ObservedObject var viewModel: OrderBucketViewModel
    @Binding var selectedTab: MainTabView.Tab
    
    init(orderBucket: OrderBucket, selectedTab: Binding<MainTabView.Tab>) {
        self.orderBucket = orderBucket
        self.viewModel = OrderBucketViewModel(orderBucket: orderBucket)
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color("courierTheme")).frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 9)
            HStack {
                VStack {
                    Text("\(timestampString)")
                        .font(.system(size: 15, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    Text("Pickup: \(orderBucket.restaurantName)")
                        .font(.system(size: 13, weight: .thin, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    Text("Dropoff: \(orderBucket.destination)")
                        .font(.system(size: 13, weight: .thin, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    Text("# of deliveries: \(viewModel.numberOfOrders)")
                        .font(.system(size: 13, weight: .thin, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                }.foregroundColor(Color.black)
                    NavigationLink {
                        OrderBucketView(orderBucket: orderBucket, viewModel: self.viewModel, selectedTab: $selectedTab)
                    } label: {
                        Text("Take Order")
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .padding()
                            .foregroundColor(.black).background(Color(hex: "fffafa"))
                            .cornerRadius(15)
                            .padding(.trailing, 15)
                    }
                }
            }.frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 9, alignment: .center)
        
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let date = orderBucket.timeCreated.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        // Convert Date to String
        let string = dateFormatter.string(from: date)
        return string
    }
}

