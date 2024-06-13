//
//  StartOrderView.swift
//  lynx
//
//  Created by Jeremy Suh on 6/26/22.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI

struct StartOrderView: View {
    @State private var showingAlert = false
    @State private var insufficient = false
    @State var orderNumber = ""
    @State var orderItem = ""
    @State var deliveryInstructions = ""
    @State var customTip = ""
    @State private var presentAlert = false
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject var appState: AppState
    let deliveryDestination: String
    let user: User
    let restaurant: Restaurant
    let location1: Location
    @State private var didTap1: Int = 0
    @State private var didTap2: Int = 0
    @State private var didTap3: Int = 0
    var deliveryConstant = 2.0
    var deliveryCoeff = 2.0
    @Binding var selectedTab: MainTabView.Tab
   
    @ObservedObject var viewModel = ConsumerOrderViewModel(restaurantName: "Auntie Anne's")
    
    var body: some View {
        ScrollView {
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
                        Text("**Phone:** \(restaurant.restaurantPhoneNumber)") // STATIC TEXT: NEED ORDER.RESTAURANTPHONE
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 25)
                        HStack {
                            Text("**Website:** ")
                            Link(destination: URL(string: "\(restaurant.restaurantWebsite)")!) {
                                Text("Order pickup here")
                            }
                        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 25)
                        
                       // Text("**Website:** \(restaurant.restaurantWebsite)") //STATIC TEXT: NEED ORDER.WEBSITELINK
                            
                        Text("**Dropoff:** \(deliveryDestination)")
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
                        
                        TextField("i.e. Pepsi for drink", text: $deliveryInstructions
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
                        Text("\((distance * deliveryCoeff) + deliveryConstant, format: .currency(code: "USD"))")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                    }
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                    .padding(.top, 8)
                
                    HStack {
                        // STATIC TEXT: Create an algorithm for calculating sales tax --> 6% in VA --> 0.06 * order.deliveryPrice
                        Text("Taxes")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        // Replace this with a variable for price
                        Text("\(((distance * deliveryCoeff) + deliveryConstant) * 0.06, format: .currency(code: "USD"))")
                            .font(.system(size: 18, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)

                    }
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                    .padding(.top, 8)

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
                        Text("\((((distance * deliveryCoeff) + deliveryConstant) * 1.06 + (Double(customTip) ?? 0.00)), format: .currency(code: "USD"))")
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
                if ((Double(user.balance - 1)/100) > ((((distance * deliveryCoeff) + deliveryConstant) * 1.06 + (Double(customTip) ?? 0.00)))){
                viewModel.createOrder(orderNumber: orderNumber, orderItem: orderItem, deliveryInstructions: deliveryInstructions, deliveryDestination: deliveryDestination, user: user, restaurantName: restaurant.restaurantName, deliveryCost: (distance * deliveryCoeff), tip: Double(customTip) ?? 0.0)
                }
                else {
                    // Shows they don't have enough funds
                    insufficient = true
                }
                presentAlert = true
            }, label: {
                Text("START ORDER")
                    .padding()
                    .frame(maxWidth: UIScreen.main.bounds.width - 30)
                    .foregroundColor(.white)
                    .background(Color("lynxPurple"))
                    .cornerRadius(15)
            }).alert(isPresented: $presentAlert) {
                if insufficient {
                    return Alert(
                        title: Text("Please add money to your lynx balance to make this order!"),
                        message: Text(""),
                        dismissButton: .default(Text("OK")))
                } else {
                    return Alert(
                        title: Text("Order Success!"),
                        message: Text(""),
                        dismissButton: .default(Text("OK")) {
                            appState.rootViewId = UUID()
                            self.selectedTab = MainTabView.Tab.orders
                        })
                }
            }.onAppear {
                locationManager.convertAddress(address: self.restaurant.restaurantAddress)
            }
            
            Spacer().frame(height: 15)
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






//VStack{
//
//TextField("Order Number", text: $orderNumber)
//TextField("Order Item", text: $orderItem)
//TextField("Delivery Instructions", text: $deliveryInstructions)
//TextField("Delivery Destination", text: $deliveryDestination)
//
//Button {
//    viewModel.createOrder(orderNumber: orderNumber, orderItem: orderItem, deliveryInstructions: deliveryInstructions, deliveryDestination: deliveryDestination, user: user, restaurantName: restaurantName)
//} label: {
//    Text("Start Order")
//}
//
//
//}
