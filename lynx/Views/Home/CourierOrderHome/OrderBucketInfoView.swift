//
//  OrderBucketInfoView.swift
//  lynx
//
//  Created by Andrew Tran on 8/21/22.
//

import SwiftUI
import MapKit
import CoreLocationUI
import CoreLocation

// shows the information of the order that a courier can take
struct OrderBucketViewInfo: View {
   
    @Environment(\.presentationMode) var presentationMode
    let orderBucket: OrderBucket
    let viewModel: OrderBucketViewModel
    let status: String
    var dropoffLocation: Location
    @StateObject var locationManager = LocationManager()
    @ObservedObject var viewModel2: CourierOrdersViewModel
    @State var minDistance = 0.2
    @State private var presentAlert = false
    @State private var showingAlert = false
    @State private var presentOtherAlert = false
    @State private var distanceCutoff = 0.2
    
    init(orderBucket: OrderBucket, viewModel: OrderBucketViewModel, status: String, viewModel2: CourierOrdersViewModel) {
        self.orderBucket = orderBucket
        self.viewModel = viewModel
        self.status = status
        self.dropoffLocation = LocationsDataService.locations[LocationsDataService.locations.firstIndex(where: {$0.name == orderBucket.destination})!]
        self.viewModel2 = viewModel2
    }
    
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
                // MARK: ADD delivery comp and tips fields in orderbucket
//                Text("**Delivery Compensation:** \(comp)")
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
            
            ForEach(viewModel.orders) { order in
                OrderListCard(order: order)
            }
            completeBtn
                .onAppear(){
                    locationManager.requestLocation()
                }
        }
    }
    
    var completeBtn: some View {
        if status == "completed" {
            return AnyView(Text(""))
        } else {
            return AnyView(
                Button(action: {
//                    if (!distanceChecker()) {
                        viewModel.completeOrder(orderBucket: self.orderBucket)
                        viewModel.takeMoney(orderBucket: self.orderBucket)
                        viewModel.sendNotification(orderBucket: self.orderBucket)
//                    }
                    presentAlert = true
                    
                }, label: {
                    Text("Complete Order")
                        .font(.system(size: 23, weight: .bold, design: .default))
                        .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .center)
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(Color("courierTheme"))
                        .cornerRadius(100)
                }).alert(isPresented: $presentAlert) {
                    let formatted = String(format: "%.2f", viewModel.tips)
//                    if (false) {
//                        return Alert(
//                            title: Text("You seem to be far away from your dropoff point. Please move closer to the dropoff location and try again or contact ‪(434) 373-0234‬."),
//                            message: Text(""),
//                            dismissButton: .default(Text("OK"))
//                        )
//                    } else {
                        return Alert(
                            title: Text("You earned an extra $\(formatted) in tips!"),
                            message: Text(""),
                            dismissButton: .default(Text("OK")) {
                                self.presentationMode.wrappedValue.dismiss()
                                viewModel2.fetchOrder()
                                viewModel2.filterOrders()
                                viewModel2.fetchCompletedBuckets()
                            }
                        )
//                    }
                    
                    
                }
            )
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
    
    func distanceChecker() -> Bool{
        if let location = locationManager.location{
            return getDistance(lat1: location.latitude, long1: location.longitude, lat: dropoffLocation.coordinates.latitude, long: dropoffLocation.coordinates.longitude) > distanceCutoff
        }
        return true
    }
    
    func getDistance(lat1: Double, long1: Double, lat: Double, long: Double) -> CLLocationDistance{
        let from = CLLocation(latitude: lat1, longitude: long1)
        let to = CLLocation(latitude: lat, longitude: long)
        return from.distance(from: to) * 0.000621371192
    }
}

struct OrderListCard: View {
    let order: Order
    
    var body: some View {
        Group {
            Text("**Name:** \(order.customerName)")
           
            Text("**Order Number:** \(order.orderNumber)")
            Text("**Order Item:** \(order.orderItem)")
            Text("**Delivery Instructions:** \(order.deliveryInstructions)")
            
            HStack{
            Text("**Phone Number:**")
                Link("\(order.customerPhone)", destination: URL(string: "tel:\(order.customerPhone)")!)
            }
        }      .padding(.bottom, 2)
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            .padding(.leading, 15)
        
        Divider()
            .background(Color.gray)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 5)
            .padding(.trailing, 20)
            .padding(.leading, 20)
            .padding(.bottom, 10)
        
    }
}
