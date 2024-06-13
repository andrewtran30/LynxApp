//
//  HomeViewModel.swift
//  lynx
//
//  Created by Jeremy Suh on 6/26/22.
//

import Foundation
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var restaurants = [Restaurant]()
    @Published var activeOrders = [OrderBucket]()

    init() {
        fetchRestaurants()
        fetchBuckets()
        filterOrders()        
    }
    
    func fetchRestaurants() {
        Firestore.firestore().collection("restaurants").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.restaurants = documents.compactMap( {try? $0.data(as: Restaurant.self) })
        }
    }
    
    
    func fetchBuckets() {
        Firestore.firestore().collection("orderBuckets").whereField("orderState", isEqualTo: "Joinable").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.activeOrders = documents.compactMap( {try? $0.data(as: OrderBucket.self) })
            
            let currTime = Timestamp(date: Date())
            for bucket in self.activeOrders {
                if ((currTime - bucket.timeCreated) > 600) {
                    print("converted")
                    Firestore.firestore().collection("orderBuckets").document(bucket.id!).updateData(["orderState": "Pending"])
                    
                }
            }
        }
    }
    
    func filterOrders() {
        let currTime = Timestamp(date: Date())
        for bucket in self.activeOrders {
            if ((currTime - bucket.timeCreated) > 600) {
                print("converted")
                Firestore.firestore().collection("orderBuckets").document(bucket.id!).updateData(["orderState": "Pending"])
                
            }
        }
    }


}
