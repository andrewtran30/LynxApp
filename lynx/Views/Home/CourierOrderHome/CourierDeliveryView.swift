//
//  CourierDeliveryView.swift
//  lynx
//
//  Created by Andrew Tran on 7/10/22.
//

import SwiftUI

struct CourierDeliveryView: View {
    let orders: OrderBucket
    var body: some View {
        ScrollView {
            VStack {
             Text("Delivery Info")
                    .font(.system(size: 36, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 5)
                    .padding(.leading, 15)
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color("lynxPurple")).frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 5)
                        .shadow(color: Color.gray.opacity(0.7), radius: 8, x: 0, y: 8)
                    VStack {
                        Text("DELIVERY TO:")
                               .font(.system(size: 14, weight: .bold, design: .default))
                               .frame(maxWidth: .infinity, alignment: .center)
                               .padding(.bottom, 5)
                               .foregroundColor(Color.white)
                        Text("\(orders.destination)")
                               .font(.system(size: 24, weight: .bold, design: .default))
                               .frame(maxWidth: .infinity, alignment: .center)
                               .padding(.bottom, 5)
                               .foregroundColor(Color.white)
                    }
                }
            }.padding(.bottom, 15)
            HStack {
                Text("Consumers")
                       .font(.system(size: 26, weight: .bold, design: .default))
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding(.bottom, 5)
                       .padding(.leading, 15)
                
                Button(action: {}) {
                    Text("Delivery Info")
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color("lynxPurple"))
                        .cornerRadius(50)
                        .padding(.trailing, 15)
                        .shadow(color: Color.gray.opacity(0.7), radius: 8, x: 0, y: 8)
                }
            }
            
            VStack {
                // MARK: Put a foreach thing instead
//                MARK: ForEach(orders) { user in
            // MARK: ConsumerOrderModel(user: user) --> need the model to pass in the user so we can access the name of the user and the profile image
//                }
               
            }
            VStack {
                VStack {
                    HStack {
                        Text("**Delivery Fees:**")
                            .font(.system(size: 16, design: .default))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // MARK: Replace this with a variable for price

                        Text("$2.59")
                            .font(.system(size: 16, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }.padding(.bottom, 1)
                    HStack {
                        Text("**Tips:**")
                            .font(.system(size: 16, design: .default))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // MARK: Replace this with a variable for price
                        Text("$2.59")
                            .font(.system(size: 16, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }.padding(.bottom, 1)
                    HStack {
                        Text("**Total:**")
                            .font(.system(size: 16, design: .default))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // MARK: Replace this with a variable for price

                        Text("$2.59")
                            .font(.system(size: 16, design: .default))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)

                    }.padding(.bottom, 1)
                }.padding(25)
                
                Button(action: {}) {
                    Text("**Finish**").font(.system(size: 23, weight: .bold, design: .default))
                }
                .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .center)
                .padding(10)
                .foregroundColor(Color.white)
                .background(Color("lynxPurple"))
                .cornerRadius(100)
            }
        }
    }
}

//struct CourierDeliveryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourierDeliveryView()
//    }
//}
