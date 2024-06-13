//
//  OrderBucketViewModel.swift
//  lynx
//
//  Created by Jeremy Suh on 7/10/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class OrderBucketViewModel: ObservableObject {
    let orderBucket: OrderBucket
    @Published var orders = [Order]()
    @Published var tips = 0.0
    @Published var numberOfOrders = 0

    init(orderBucket: OrderBucket) {
        self.orderBucket = orderBucket
        fetchOrders(id: orderBucket.id!)
    }
    
    
    func sendNotification(orderBucket: OrderBucket) {
        
        for order in orders {
            
            let orderData = ["to": "1\(order.customerPhone)",
                             "type": "text",
                             "channelId":"db48ef6445ef46efaaa0104c3d81d25f",
                             "content": [ "text": "yo bro"]
                            ] as [String : Any]
        
        Firestore.firestore().collection("messages").addDocument(data: orderData)
            
        }
    }
    
    func takeMoney(orderBucket: OrderBucket) {
        Firestore.firestore().collection("orderBuckets").document(orderBucket.id!).collection("orders").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let orders = documents.compactMap( {try? $0.data(as: Order.self) })
            
            
            
            var courierPayout = 0.0
            
            
            for order in orders {
                courierPayout += order.tip
                let totalOrderCost = (((orderBucket.deliveryCost * orderBucket.orderMult) + 2.0) * 1.06 + order.tip) * 100
                Firestore.firestore().collection("users").whereField("phonenumber", isEqualTo: order.customerPhone).getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    
                    let user = documents.compactMap( {try? $0.data(as: User.self) })
                    
                    print(totalOrderCost)
                    print(user[0].balance)
                        
                    let newBalance = Double(user[0].balance) - Double(Int(totalOrderCost))
                    
                    print(newBalance)
                    
                    Firestore.firestore().collection("users").document(user[0].id!).updateData(["balance": newBalance])
                }
                
                
            }
            
            courierPayout = Double((orderBucket.deliveryCost * orderBucket.orderMult) + 2.0) * Double(orderBucket.numberOfOrders) * 75.0
            
            
            guard let uid = MainViewModel.shared.currentUser?.id else { return }
            Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
                guard let user = try? snapshot?.data(as: User.self) else {return}
                let newBalance = Int(user.courierBalance) + Int(courierPayout)
                Firestore.firestore().collection("users").document(user.id!).updateData(["courierBalance": newBalance])
            }
            
          
        }
    }
    
    
    func fetchOrders(id: String) {
        Firestore.firestore().collection("orderBuckets").document(id).collection("orders").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.orders = documents.compactMap( {try? $0.data(as: Order.self) })
            self.numberOfOrders = self.orders.count
            
            for order in self.orders {
                self.tips += Double(order.tip)
            }
        }
    }
    
    
    func takeOrder(orderBucket: OrderBucket) {
        guard let uid = MainViewModel.shared.currentUser?.id else { return }
        Firestore.firestore().collection("orderBuckets").document(orderBucket.id!).updateData(["orderState": "In Progress", "courier": uid])
    }
    
    func completeOrder(orderBucket: OrderBucket) {
        guard let uid = MainViewModel.shared.currentUser?.id else { return }
        Firestore.firestore().collection("orderBuckets").document(orderBucket.id!).updateData(["orderState": "Completed", "courier": uid])
    }
    
}
