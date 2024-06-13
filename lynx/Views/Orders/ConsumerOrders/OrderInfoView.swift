//
//  OrderInfoView.swift
//  lynx
//
//  Created by Jeremy Suh on 7/9/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct OrderInfoView: View {
    let order: Order
    @ObservedObject var viewModel = OrderInfoViewModel()

    init(order: Order) {
        self.order = order
        viewModel.fetchBucket(order: order)
    }
   
    var body: some View {
        ScrollView {
            VStack {
                Text("Order Information")
                    .font(.custom("Avenir", fixedSize: 25))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading).padding()
            
                Divider().frame(maxWidth: .infinity, alignment: .center)
                Group {
                    HStack {
                        Text("Name")
                            .font(.custom("Avenir", fixedSize: 20))
                            .italic()
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .leading)
                        Text("\(order.customerName)")
                            .font(.custom("Avenir", fixedSize: 15))
                            .foregroundColor(Color(UIColor.lightGray))
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .trailing)
                    }
                }.padding()
                Group {
                    HStack {
                        Text("Restaurant")
                            .font(.custom("Avenir", fixedSize: 20))
                            .italic()
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .leading)
                        Text("\(order.restaurantName)")
                            .font(.custom("Avenir", fixedSize: 15))
                            .foregroundColor(Color(UIColor.lightGray))
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .trailing)
                    }
                    HStack {
                        Text("Drop Off Location")
                            .font(.custom("Avenir", fixedSize: 20))
                            .italic()
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .leading)
                        Text("\(order.deliveryDestination)")
                            .font(.custom("Avenir", fixedSize: 15))
                            .foregroundColor(Color(UIColor.lightGray))
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .trailing)
                    }
                }.padding()
                Divider().frame(maxWidth: .infinity, alignment: .center)
                Group {
                    HStack {
                        if(order.orderNumber != nil) {
                        Text("Order #")
                                .font(.custom("Avenir", fixedSize: 20))
                            .italic()
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .leading)
                        Text("\(order.orderNumber)")
                                .font(.custom("Avenir", fixedSize: 15))
                            .foregroundColor(Color(UIColor.lightGray))
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .trailing)
                        }
                    }
                    
                    HStack {
                        if(viewModel.orderBucket?.deliveryCost != nil) {
                        Text("Total Cost")
                                .font(.custom("Avenir", fixedSize: 20))
                            .italic()
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .leading)
                            Text("\(((((viewModel.orderBucket?.deliveryCost ?? 1.0) * (viewModel.orderBucket?.orderMult ?? 1.0) + 2.0) * 1.06) + order.tip), format: .currency(code: "USD"))")
                                .font(.custom("Avenir", fixedSize: 15))
                            .foregroundColor(Color(UIColor.lightGray))
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .trailing)
                        }
                    }
                }.padding()
                Group {
                    HStack {
                        Text("Delivery Instructions")
                            .font(.custom("Avenir", fixedSize: 20))
                            .italic()
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .leading)
                        Text("\(order.deliveryInstructions)")
                            .font(.custom("Avenir", fixedSize: 15))
                            .foregroundColor(Color(UIColor.lightGray))
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .trailing)
                    }
                }.padding()
                Group {
                    HStack {
                        Text("Item Ordered")
                            .font(.custom("Avenir", fixedSize: 20))
                            .italic()
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .leading)
                        Text("\(order.orderItem)")
                            .font(.custom("Avenir", fixedSize: 15))
                            .foregroundColor(Color(UIColor.lightGray))
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .trailing)
                    }
                }.padding()
                Group {
                    HStack {
                        Text("Time stamp")
                            .font(.custom("Avenir", fixedSize: 20))
                            .italic()
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .leading)
                        Text("\(timestampString)")
                            .font(.custom("Avenir", fixedSize: 15))
                            .foregroundColor(Color(UIColor.lightGray))
                            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .trailing)
                    }
                }.padding()
            }
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

//                Group {
//                    HStack {
//                        Text("Delivery Status")
//                            .font(.system(size: 20, design: .default))
//                            .italic()
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        Text("\(viewModel.order.fulfilled ?? "Pending")")
//                            .font(.system(size: 15, design: .default))
//                            .foregroundColor(Color(UIColor.lightGray))
//                    }
//                }.padding()
//                Group {
//                    HStack {
//                        Text("Courier")
//                            .font(.system(size: 20, design: .default))
//                            .italic()
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        Text("\(viewModel.order.courierfulfilled ?? "Finding Courier...")")
//                            .font(.system(size: 15, design: .default))
//                            .foregroundColor(Color(UIColor.lightGray))
//                    }
//                }.padding()
