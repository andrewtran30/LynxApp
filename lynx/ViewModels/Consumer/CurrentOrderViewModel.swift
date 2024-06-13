//
//  CurrentOrderViewModel.swift
//  lynx
//
//  Created by Jeremy Suh on 6/27/22.
//


import SwiftUI
import Firebase
import FirebaseFirestore


class CurrentOrderViewModel: ObservableObject {
//    let user: User
    @Published var order = [Order]()
    @Published var buckets = [OrderBucket]()
    
    init() {
        fetchOrder()
        filterOrders()
    }

    
    func fetchOrder() {
        guard let user = MainViewModel.shared.currentUser else { return }
        self.order.removeAll()
        Firestore.firestore().collection("orderBuckets").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.buckets = documents.compactMap( {try? $0.data(as: OrderBucket.self) })
            for bucket in self.buckets {
                Firestore.firestore().collection("orderBuckets").document(bucket.id!).collection("orders").whereField("customerPhone", isEqualTo: user.phonenumber).getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    let orders = (documents.compactMap({try? $0.data(as: Order.self)}))
                    for order in orders {
                        self.order.append(order)
                    }
                }
            }
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

extension Timestamp {

    static func - (leftHandSide: Timestamp, rightHandSide: Timestamp) -> Int64 {
        return leftHandSide.seconds - rightHandSide.seconds
    }

}
