//
//  CourierOrdersViewModel.swift
//  lynx
//
//  Created by Jeremy Suh on 7/13/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore


class CourierOrdersViewModel: ObservableObject {
//    let user: User
    @Published var order = [Order]()
    @Published var buckets = [OrderBucket]()
    @Published var completedOrders = [OrderBucket]()
    
    init() {
        fetchOrder()
        fetchCompletedBuckets()
        filterOrders()
    }

    
    func fetchOrder() {
        guard let user = MainViewModel.shared.currentUser else { return }
        self.order.removeAll()
        Firestore.firestore().collection("orderBuckets").whereField("orderState", isEqualTo: "In Progress").whereField("courier", isEqualTo: user.id).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.buckets = documents.compactMap( {try? $0.data(as: OrderBucket.self) })
            
            
            for bucket in self.buckets {
                Firestore.firestore().collection("orderBuckets").document(bucket.id!).collection("orders").getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    let orders = (documents.compactMap({try? $0.data(as: Order.self)}))
                    for order in orders {
                        self.order.append(order)
                    }
                }
            }
        }
    }
    
    func fetchCompletedBuckets() {
        guard let user = MainViewModel.shared.currentUser else { return }
        self.order.removeAll()
        Firestore.firestore().collection("orderBuckets").whereField("orderState", isEqualTo: "Completed").whereField("courier", isEqualTo: user.id).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.completedOrders = documents.compactMap( {try? $0.data(as: OrderBucket.self) })
        }
    
    }
    
    func filterOrders() {
        let currTime = Timestamp(date: Date())
        

        for bucket in self.buckets {
            if ((currTime - bucket.timeCreated) > 600) {
                print("the bucket has expired because 600 seconds = 10 mins.")
            }
        }
    }
}


