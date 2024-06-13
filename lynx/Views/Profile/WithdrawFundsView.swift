//
//  WithdrawFundsView.swift
//  lynx
//
//  Created by Jeremy Suh on 8/25/22.
//

import SwiftUI

struct WithdrawFundsView: View {
    @ObservedObject var viewModel: MainViewModel
    var user: User
    @State private var venmo: String
    
    init(viewModel: MainViewModel, user: User){
        self.viewModel = viewModel
        self.user = user
        self._venmo = State(initialValue: user.venmo ?? "")
    }
    
    var body: some View {
        VStack {
            Divider()
            Text("Enter your venmo handle:").font(.system(size: 24))
             
            Divider()
            
            HStack{
                Spacer().frame(width: 5)
                Image("venmo").resizable().scaledToFit().frame(width: 40)
            TextField("Venmo", text: $venmo).font(.system(size: 25))
                .font(.headline).disableAutocorrection(true)
                if(self.venmo != user.venmo) {
                    Button {
                        viewModel.saveVenmo(venmo: venmo)
                    } label: {
                      Text("✔️")
                    }
                }
                Spacer().frame(width: 5)
            }
//            Button {
//                viewModel.saveVenmo(venmo: venmo)
//            } label: {
//                Text("Update Venmo")
//            }

            Text("Money to be withdrawn $\(Double(user.courierBalance) / 100.0, specifier: "%.2f")")
            
            Button {
                viewModel.withdrawBalance()
            } label: {
                HStack {
                    Text("CONFIRM WITHDRAW").fontWeight(.bold)
                }
                .frame(minWidth: 200)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(6)
                .accessibility(identifier: "Buy button")
            }
        Spacer()
            
        }.onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        
        
    }
}

