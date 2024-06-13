//
//  OrderCardView.swift
//  lynx
//
//  Created by Jeremy Suh on 7/8/22.
//

import SwiftUI

struct OrderCardView: View {
   
    let order: Order
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color("lynxPurple")).frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 9)
            HStack {
                VStack {
                    Text("\(timestampString)")
                        .font(.custom("Avenir", size: 17))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    Text("Pickup: \(order.restaurantName)")
                        .font(.custom("Avenir", size: 14))
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    Text("Dropoff: \(order.deliveryDestination)")
                        .font(.custom("Avenir", size: 14))
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                }
                NavigationLink {
                    OrderInfoView(order: order)
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
        let date = order.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        // Convert Date to String
        let string = dateFormatter.string(from: date)
        return string
    }
}

