//
//  AddFundsView.swift
//  lynx
//
//  Created by Andrew Tran on 6/28/22.
//

import Stripe
import SwiftUI

import FirebaseFirestore
// https://stripe-mobile-payment-sheet.glitch.me/checkout
// https://us-east4-lynx-978c4.cloudfunctions.net/ext-firestore-stripe-payments-handleWebhookEvents

class MyBackendModel: ObservableObject {
    
  let backendCheckoutUrl = URL(string: "https://us-east4-lynx-978c4.cloudfunctions.net/ext-firestore-stripe-payments-handleWebhookEvents")! // backend endpoint
  @Published var paymentSheet: PaymentSheet?
  @Published var paymentResult: PaymentSheetResult?
    
    @State var user: User?
    @State var paymentAmount = 0
    
    
    init() {
        fetchUser()
    }
    
    
    func fetchUser() {
        guard let user = MainViewModel.shared.currentUser else { return }
        Firestore.firestore().collection("users").document(user.id ?? "").getDocument  { snapshot, _ in
            self.user = try? snapshot?.data(as: User.self)
        }
    }
    
    
    
    func firebasePaymentSheet(amount: Int) {
        
        
        let bucketData: [String: Any] = ["amount": amount,
                                         "client": "mobile",
                                         "currency": "usd",
                                         "mode": "payment"]
        
        
        
        guard let uid = MainViewModel.shared.currentUser?.id else { return }
        
        let ref = Firestore.firestore().collection("customers").document(uid).collection("checkout_sessions").addDocument(data: bucketData)
        
        ref.addSnapshotListener(includeMetadataChanges: true){ snapshot, _ in
            guard let addedInfo = snapshot else { return }
            
            guard let customerId = addedInfo.get("customer") as? String else { return }
            guard let customerEphemeralKeySecret = addedInfo.get("ephemeralKeySecret") as? String else { return }
            guard let paymentIntentClientSecret = addedInfo.get("paymentIntentClientSecret") as? String else { return }
            let publishableKey = "pk_live_51KhRpTByADKDQsmxTmGOcQnnEGHKBVXGxQhc13nBJNkTAaKdSKrPIZgmoml9fdHZnsuZm7Nq7XvL2VCcxB7U9aMV00etdiyM0m"
            
            STPAPIClient.shared.publishableKey = publishableKey
            // MARK: Create a PaymentSheet instance
            var configuration = PaymentSheet.Configuration()
            configuration.returnURL = "lynx://stripe-redirect"
            configuration.merchantDisplayName = "Lynx Delivery"
            configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            // Set `allowsDelayedPaymentMethods` to true if your business can handle payment
            // methods that complete payment after a delay, like SEPA Debit and Sofort.
            configuration.allowsDelayedPaymentMethods = false

            DispatchQueue.main.async {
                print("trying something")
                
              self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
            }
        
            
            
        
        }
     
        
    }
    
//  func preparePaymentSheet() {
//    // MARK: Fetch the PaymentIntent and Customer information from the backend
//    var request = URLRequest(url: backendCheckoutUrl)
//    request.httpMethod = "POST"
//
//    let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
//
//        guard let data = data else {
//            print("data")
//            return }
//
//        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
//            print("json")
//            return }
//
//        guard let customerId = json["customer"] as? String else {
//            return  }
//        guard let customerEphemeralKeySecret = json["ephemeralKey"] as? String else {
//            return }
//        guard let paymentIntentClientSecret = json["paymentIntent"] as? String else {
//            return }
//        guard let publishableKey = json["publishableKey"] as? String else {
//            return }
//        guard let self = self else {
//          print("errored again")
//        // Handle error
//        return
//      }
//
//
//
//      STPAPIClient.shared.publishableKey = publishableKey
//      // MARK: Create a PaymentSheet instance
//      var configuration = PaymentSheet.Configuration()
//      configuration.returnURL = "lynx://stripe-redirect"
//      configuration.merchantDisplayName = "Lynx Delivery"
//      configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
//      // Set `allowsDelayedPaymentMethods` to true if your business can handle payment
//      // methods that complete payment after a delay, like SEPA Debit and Sofort.
//      configuration.allowsDelayedPaymentMethods = false
//
//      DispatchQueue.main.async {
//          print("trying something")
//        self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
//      }
//    })
//    task.resume()
//  }
    
    func onPaymentCompletion(result: PaymentSheetResult, amount: Int) {
      self.paymentResult = result
        switch paymentResult {
            case .completed:
            guard let uid = MainViewModel.shared.currentUser?.id else { return }
            Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
                let user = try? snapshot?.data(as: User.self)
              
                let newBalance = (user?.balance ?? 0) + (amount)
                print(newBalance)
                Firestore.firestore().collection("users").document(uid).updateData(["balance": newBalance])
            }
            
              print("Your order is confirmed")
            case .canceled:
              print("Canceled!")
            case .failed(let error):
              print("Payment failed: \(error)")
            default:
                print("default")
        }
      
     
    }
}

class PaymentMethodModel: ObservableObject {
    @Published var paymentMethod = "Credit Card"
}

struct AddFundsView: View {
   
    @ObservedObject var model = MyBackendModel()
    @StateObject var paymentModel = PaymentMethodModel()
    @State var depositAmount = 0
    @State var loadingView = false

    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            Group {
                if let userBalance = model.user?.balance {
                Text("Current Balance: $\(userBalance)")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(5)
                }
                Divider().frame(maxWidth: .infinity)
                Spacer().frame(height: 25)
            }
            Group {
                Text("Select Amount")
                    .fontWeight(.thin)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
                Spacer().frame(height: 25)
                HStack {
                    Button(action: {
                        depositAmount = 500
                        if(model.paymentAmount != 500) {
                            model.paymentSheet = nil
                        }
                        model.firebasePaymentSheet(amount: depositAmount)
                    }, label: {
                        Text("$5")
                            .fontWeight(.thin)
                            .font(.system(size: 15))
                            .frame(maxWidth: 100)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(depositAmount == 500 ? Color.orange : Color.purple)
                            .cornerRadius(40)
                    })
                    Button(action: {
                        depositAmount = 1000
                        if(model.paymentAmount != 1000) {
                            model.paymentSheet = nil
                        }
                        model.firebasePaymentSheet(amount: depositAmount)
                    }, label: {
                        Text("$10")
                            .fontWeight(.thin)
                            .font(.system(size: 15))
                            .frame(maxWidth: 100)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(depositAmount == 1000 ? Color.orange : Color.purple)
                            .cornerRadius(40)
                    })
                    Button(action: {
                         depositAmount = 2000
                        if(model.paymentAmount != 2000) {
                            model.paymentSheet = nil
                        }
                        model.firebasePaymentSheet(amount: depositAmount)
                    }, label: {
                        Text("$20")
                            .fontWeight(.thin)
                            .font(.system(size: 15))
                            .frame(maxWidth: 100)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(depositAmount == 2000 ? Color.orange : Color.purple)
                            .cornerRadius(40)
                    })
                 
                }
                Spacer().frame(height: 25)
                Divider().frame(maxWidth: .infinity)
            }
            Group {
                Spacer().frame(height: 20)
                HStack {
                    Text("Payment Method")
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    Menu {
//                        Button(action: {
//                            paymentModel.paymentMethod = "Apply Pay >"
//                            print(paymentModel.paymentMethod)
//                        }, label: {
//                            Text("Apple Pay")
//                        })
                        Button(action: {
                            paymentModel.paymentMethod = "Credit Card >"
                            print(paymentModel.paymentMethod)
                        }, label: {
                            Text("Credit Card")
                        })
                    } label: {
                        Text(paymentModel.paymentMethod).padding(.trailing, 15)
                    }
                }
                Spacer().frame(height: 20)
                HStack {
                    Text("New Balance")
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    if let userBalance = model.user?.balance {
                    Text("\(userBalance)")
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 15)
                    }
                }
            }
            Spacer()
            VStack {
                if let paymentSheet = model.paymentSheet {
                    PaymentSheet.PaymentButton(
                        paymentSheet: paymentSheet,
                        onCompletion: { result in
                            model.onPaymentCompletion(result: result, amount: depositAmount)
                        }
                    ) {
                        ExamplePaymentButtonView()
                    }
                } else {
                    ExampleLoadingView()
//                    if(loadingView != true) {
//                    Button {
//                        loadingView = true
//                        loadingView = model.firebasePaymentSheet(amount: depositAmount)
//                    } label: {
//                        ConfirmAmount()
//                    }
//                    } else {
//                        ExampleLoadingView()
//                    }
                }
                if let result = model.paymentResult {
                    ExamplePaymentStatusView(result: result)
                }
                
              
            }
        }
    }
}

