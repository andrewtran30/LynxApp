//
//  CourierOrderCard.swift
//  lynx
//
//  Created by Andrew Tran on 8/21/22.
//

import SwiftUI

struct CourierOrderCard: View {
    let bucket: OrderBucket
    let status: String
    let viewModel: OrderBucketViewModel
    @ObservedObject var viewModel2: CourierOrdersViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color("courierTheme")).frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 9)
            HStack {
                VStack {
                    Text("\(timestampString)")
                        .font(.custom("Avenir", size: 17))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    Text("Pickup: \(bucket.restaurantName)")
                        .font(.custom("Avenir", size: 14))
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    Text("Dropoff: \(bucket.destination)")
                        .font(.custom("Avenir", size: 14))
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                }
                NavigationLink {
                    OrderBucketViewInfo(orderBucket: bucket, viewModel: OrderBucketViewModel(orderBucket: bucket), status: status, viewModel2: viewModel2)
                } label: {
                    Text("Info")
                        .font(.custom("Avenir", size: 15))
                        .bold()
                        .padding()
                        .foregroundColor(.black).background(Color.white)
                        .cornerRadius(15)
                        .padding(.trailing, 15)
                }

                  
                        
            }.frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 9, alignment: .center)
        }
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let date = bucket.timeCreated.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        // Convert Date to String
        let string = dateFormatter.string(from: date)
        return string
    }
}
