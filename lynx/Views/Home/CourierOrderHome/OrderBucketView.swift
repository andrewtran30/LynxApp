//
//  OrderBucketView.swift
//  lynx
//
//  Created by Jeremy Suh on 7/10/22.
//

import SwiftUI

// shows the information of the order that a courier can take
struct OrderBucketView: View {
    let orderBucket: OrderBucket
    let viewModel: OrderBucketViewModel
//    @ObservedObject var viewModel2: CourierOrdersViewModel
    @Binding var selectedTab: MainTabView.Tab
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                .fill(Color("courierTheme")).frame(width: .infinity, height: UIScreen.main.bounds.height / 4)
                    
                    Text("Good Times, Go Hoos.")
                        .font(.custom("Avenir", fixedSize: 40))
                        .foregroundColor(Color.white)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                    
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4, alignment: .center)
            }
            Group {
                Text("**Pickup Location:** \(orderBucket.restaurantName)")
                Text("**Dropoff Location:** \(orderBucket.destination)")
                Text("**Order Count:** \(orderBucket.numberOfOrders)")
                Text("**Time stamp:** \(timestampString)")
//                Text("**Courier Payout:** $\((Double(orderBucket.numberOfOrders) * ((orderBucket.orderMult * orderBucket.deliveryCost) + 2.0)), specifier: "%.2f")")
                // MARK: ADD delivery comp and tips fields in orderbucket
                Text("**Delivery Compensation:** $\((Double(orderBucket.numberOfOrders) * ((orderBucket.orderMult * orderBucket.deliveryCost) + 2.0)) * 0.75, specifier: "%.2f")")
//                Text("**Tips:** \(tips)")
//                Text("**Total:** \(total)")
            }
            .padding(.bottom, 2)
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            .padding(.leading, 15)
            Divider()
                .background(Color.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 5)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                .padding(.bottom, 10)
            Button(action: {
                viewModel.takeOrder(orderBucket: orderBucket)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.presentationMode.wrappedValue.dismiss()
                    selectedTab = MainTabView.Tab.orders
                }
                
                
                
                
            }) {
                Text("Take Delivery")
                    .font(.custom("Avenir", size: 23))
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .center)
                    .padding(10)
                    .foregroundColor(Color.white)
                    .background(Color("courierTheme"))
                    .cornerRadius(100)
            }
            
            
        }
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
