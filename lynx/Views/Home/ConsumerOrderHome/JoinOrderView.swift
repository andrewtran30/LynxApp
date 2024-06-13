//
//  JoinOrderView.swift
//  lynx
//
//  Created by Jeremy Suh on 6/27/22.
//

import MapKit
import CoreLocation
import SwiftUI

struct JoinOrderView: View {
    let order: OrderBucket
    let user: User
 
    @State var orderNumber = ""
    @State var orderItem = ""
    @State var deliveryInstructions = ""
    @State var deliveryDestination = ""
    @State var customTip = ""
    @State private var presentAlert = false
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: ConsumerOrderViewModel
    @StateObject private var locationManager = LocationManager()
    @Binding var selectedTab: MainTabView.Tab
    @State private var progress = 0.5
    
    let location1: Location
    var deliveryConstant = 2.0
    var deliveryCoeff = 2.0
    
    init(location1: Location, order: OrderBucket, user: User, selectedTab: Binding<MainTabView.Tab>) {
        self.location1 = location1
        self.order = order
        self.user = user
        self._selectedTab = selectedTab
        
        self.viewModel = ConsumerOrderViewModel(restaurantName: order.restaurantName)
        
//        viewModel.fetchRestaurant(restaurant: order.restaurantName)
//        print(viewModel.restaurant?.restaurantAddress)
    }
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    Text("Order Options")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                        .padding(.leading, 25)
                    Divider()
                        .background(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    VStack {
                        Text("**Grubhub:** Download the app!")
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 25)
                        Text("**Phone:** \(viewModel.restaurant?.restaurantPhoneNumber ?? "")") // STATIC TEXT: NEED ORDER.RESTAURANTPHONE
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 25)
                        HStack {
                            Text("**Website:** ")
                            if let URL = URL(string: "\(viewModel.restaurant?.restaurantWebsite ?? "")") {
                            Link(destination: URL) {
                                Text("Order pickup here")
                            }
                            }
                        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 25)
                        
                       // Text("**Website:** \(restaurant.restaurantWebsite)") //STATIC TEXT: NEED ORDER.WEBSITELINK
                            
                        Text("**Dropoff:** \(order.destination)")
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 25)
                    }
                    .padding(.bottom, 10)
                }
                
                Group {
                    VStack {
                        Text("Order Information")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 25)
                            .padding(.bottom, 5)
                        Divider()
                            .background(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.trailing, 20)
                            .padding(.leading, 20)
                    }
                    HStack {
                        // Replace with dynamic text/variables
                        Text("Order Number")
                            .font(.system(size: 18, design: .default))
                            .frame(maxWidth: .infinity, alignment:   .leading)
                            .padding(.leading, 25)
                            .foregroundColor(Color.gray)
                        VStack {
                            TextField("Enter (optional)", text: $orderNumber)
                                .font(.system(size: 15, design: .default))
                                .foregroundColor(Color.gray)
                                .padding(.trailing, 25)
                            Divider()
                             .frame(height: 1)
                             .background(Color.gray)
                        }
                        .padding(.trailing, 45)
                    }
                    Divider()
                        .background(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.trailing, 20)
                        .padding(.leading, 20)
                    VStack {
                        Text("Order Item")
                            .font(.system(size: 18, design: .default))
                            .frame(maxWidth: .infinity, alignment:   .leading)
                            .padding(.leading, 25)
                            .foregroundColor(Color.gray)
                        
                        TextField("i.e. El Jefe Bowl @ Roots", text: $orderItem
                            )
                        .font(.system(size: 13))
                        .padding(12)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal, 25)
                            .padding(.bottom, 3)
                    }
                    Divider()
                        .background(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.trailing, 20)
                        .padding(.leading, 20)
                    VStack {
                        Text("Delivery Instructions")
                            .font(.system(size: 18, design: .default))
                            .frame(maxWidth: .infinity, alignment:   .leading)
                            .padding(.leading, 25)
                            .foregroundColor(Color.gray)
                        
                        TextField("i.e. Pepsi drink", text: $deliveryInstructions
                            )
                        .font(.system(size: 13)).padding(12)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal, 25)
                            .padding(.bottom, 3)
                    }
                    Divider()
                        .background(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                }
                Group {
                    Text("Delivery Tip (Optional)")
                        .font(.system(size: 18, design: .default))
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Button(action: {
                            customTip = "1"
                        }, label: {
                            Text("$1")
                                .fontWeight(.thin)
                                .font(.system(size: 15))
                                .frame(maxWidth: 92)
                                .foregroundColor(Color.black)
                                .padding(5)
                                .background((customTip == "1") ? Color("lynxPurple") : Color.gray)
                                .cornerRadius(40)
                        })
                        Button(action: {
                            customTip = "2"
                        }, label: {
                            Text("$2")
                                .fontWeight(.thin)
                                .font(.system(size: 15))
                                .frame(maxWidth: 92)
                                .foregroundColor(.black)
                                .padding(5)
                                .background((customTip == "2") ? Color("lynxPurple") : Color.gray)
                                .cornerRadius(40)
                        })

                        Button(action: {
                            customTip = "3"
                        }, label: {
                            Text("$3")
                                .fontWeight(.thin)
                                .font(.system(size: 15))
                                .frame(maxWidth: 92)
                                .foregroundColor(.black)
                                .padding(5)
                                .background((customTip == "3") ? Color("lynxPurple") : Color.gray)
                                .cornerRadius(40)
                        })
                    }
                }
                .padding(.leading, 25)
                .padding(.trailing, 25)
                .padding(.top, 8)
                .padding(.bottom, 15)
                
                Divider()
                    .background(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                
                Group {
                    Text("TOTAL")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text("Delivery Fee")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // STATIC TEXT: Replace this with a variable for price
                        Text("\(order.deliveryCost * order.orderMult + deliveryConstant, format: .currency(code: "USD"))")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                    HStack {
                        // STATIC TEXT: Create an algorithm for calculating sales tax --> 6% in VA --> 0.06 * order.deliveryPrice
                        Text("Taxes")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        // Replace this with a variable for price
                        Text("\((order.deliveryCost * order.orderMult + deliveryConstant) * 0.06, format: .currency(code: "USD"))")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)

                    }

                    HStack {
                        // STATIC
                        Text("Tip")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        // Replace this with a variable for price
                        Text("$" + "\((customTip.isEmpty ? "0.00": customTip))")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.leading, 25)
                .padding(.trailing, 25)
                .padding(.top, 8)
                
                Group {
                    Divider().frame(maxWidth: .infinity, alignment: .center)
                    HStack {
                        Text("Total")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(((order.deliveryCost * order.orderMult + deliveryConstant) * 1.06 + (Double(customTip) ?? 0.00)), format: .currency(code: "USD"))")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                    .padding(.top, 8)
                    .padding(.bottom, 50)
                    // Change this in some later time to automatically float the button to the bottom of the screen rather than have a hard-coded 50px height
                }
                Button(action: {
                    if (Double((user.balance - 1)/100) > ((((distance * deliveryCoeff) + deliveryConstant) * 1.06 + (Double(customTip) ?? 0.00)))){
                    viewModel.joinOrder(orderNumber: orderNumber, orderItem: orderItem, deliveryInstructions: deliveryInstructions, deliveryDestination: order.destination, user: user, restaurantName: order.restaurantName, order: order, deliveryCost: (distance * deliveryCoeff), tip: Double(customTip) ?? 0.0)
                        appState.rootViewId = UUID()
                        self.selectedTab = MainTabView.Tab.orders
                    }
                    else{
                        presentAlert = true
                    }
                    
                }, label: {
                    Text("JOIN ORDER")
                        .padding()
                        .frame(maxWidth: UIScreen.main.bounds.width - 30)
                        .foregroundColor(.white)
                        .background(Color("lynxPurple"))
                        .cornerRadius(15)
                })
                .alert("Please add money to your Lynx balance to make this order!", isPresented: $presentAlert, actions: {})
                
                Spacer().frame(height: 15)
//                .onAppear { locationManager.convertAddress(address: self.restaurant.restaurantAddress) }
            }
        }
    }
    
    func getDistance(lat1: Double, long1: Double, lat: Double, long: Double) -> CLLocationDistance{
        let from = CLLocation(latitude: lat1, longitude: long1)
        let to = CLLocation(latitude: lat, longitude: long)
        return from.distance(from: to) * 0.000621371192
    }
    
    var distance: Double {
        var dist = 0.00
        if let location = locationManager.location {
            dist = (getDistance(lat1: location1.coordinates.latitude, long1: location1.coordinates.longitude, lat: location.latitude, long: location.longitude))
        }
        return dist
    }
}

//struct JoinOrderView_Previews: PreviewProvider {
//    @State var orderbucket = OrderBucket(destination: "Balz Dobie",  timeCreated: Timestamp(NSDate().timeIntervalSince1970), numberOfOrders: 3, restaurantName: "Roots NK")
//    @State var dummyUser = User(email: "andrew@gmail.com", phonenumber: "12234", firstname: "Andrew", lastname: "Tran", classyear: "2025")
//    static var previews: some View {
//        JoinOrderView(order: orderbucket, user: dummyUser)
//    }
//}
