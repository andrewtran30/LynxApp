//
//  ConsumerOrderViewModel.swift
//  lynx
//
//  Created by Jeremy Suh on 6/26/22.
//

import Foundation
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class ConsumerOrderViewModel: ObservableObject {
    @State var restaurantName: String
    @State var restaurant: Restaurant?
    
    init(restaurantName: String) {
        self.restaurantName = restaurantName
//        print(restaurantName)
        fetchRestaurant(restaurant: restaurantName)
    }
    
    func createOrder(orderNumber: String, orderItem: String, deliveryInstructions: String, deliveryDestination: String, user: User, restaurantName: String, deliveryCost: Double, tip: Double) {
        
    
        var ref: DocumentReference? = nil
        
        
        let bucketData: [String: Any] = ["destination": deliveryDestination,
                                         "timeCreated": Timestamp(date: Date()),
                                         "numberOfOrders": 1,
                                         "restaurantName": restaurantName,
                                         "orderState": "Joinable",
                                         "deliveryCost": deliveryCost,
                                         "orderMult": 1.0]
        
        ref = Firestore.firestore().collection("orderBuckets").addDocument(data: bucketData) { error in
            let orderData = ["orderNumber": orderNumber,
                             "orderItem": orderItem,
                             "deliveryInstructions": deliveryInstructions,
                             "deliveryDestination": deliveryDestination,
                             "customerName": user.firstname,
                             "customerPhone": user.phonenumber,
                             "restaurantName": restaurantName,
                             "timestamp": Timestamp(date: Date()),
                             "deliveryCost": deliveryCost,
                             "tip": tip,
                             "orderBucket": ref!.documentID,
                             "userUid": user.id] as [String: Any]
            Firestore.firestore().collection("orderBuckets").document(ref!.documentID).collection("orders").addDocument(data: orderData)
}
            
    }
    
    func joinOrder(orderNumber: String, orderItem: String, deliveryInstructions: String, deliveryDestination: String, user: User, restaurantName: String, order: OrderBucket, deliveryCost: Double, tip: Double) {
        var ref: DocumentReference? = nil
        var orderMult: Double = 1.0
        
        Firestore.firestore().collection("orderBuckets").document(order.id!).getDocument {snapshot, _ in
            guard let orderBucket = try? snapshot?.data(as: OrderBucket.self) else {return}
           
            let orderNumber = orderBucket.numberOfOrders
            
            if(orderNumber == 1) {
                orderMult = 0.7
            } else if orderNumber == 2 {
                orderMult = 0.5
            } else if orderNumber == 3 {
                orderMult = 0.35
            } else if orderNumber == 4 {
                orderMult = 0.2
            } else {
                print("failed to join order (too many people on order)")

            }
            
            Firestore.firestore().collection("orderBuckets").document(order.id!).updateData(["numberOfOrders": FieldValue.increment(Int64(1)), "orderMult": orderMult])
            
            let orderData = ["orderNumber": orderNumber,
                             "orderItem": orderItem,
                             "deliveryInstructions": deliveryInstructions,
                             "deliveryDestination": deliveryDestination,
                             "customerName": user.firstname,
                             "customerPhone": user.phonenumber,
                             "restaurantName": order.restaurantName,
                             "timestamp": Timestamp(date: Date()),
                             "deliveryCost": deliveryCost * (orderMult),
                             "tip": tip,
                             "orderBucket": order.id,
                             "userUid": user.id] as [String: Any]
            Firestore.firestore().collection("orderBuckets").document(order.id!).collection("orders").addDocument(data: orderData)
        }
    }
    
    func fetchRestaurant(restaurant: String) {
        
//        print(restaurant)
        
        Firestore.firestore().collection("restaurants").whereField("restaurantName", isEqualTo: restaurant).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let rest = documents.compactMap( {try? $0.data(as: Restaurant.self) })
            if rest.count > 0 {
//                print(rest[0].restaurantName)
            self.restaurant = rest[0]
            }
        }
    }

}
