//
//  CourierHomeViewModel.swift
//  lynx
//
//  Created by Jeremy Suh on 7/30/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class CourierHomeViewModel: ObservableObject {
    @Published var orderBuckets = [OrderBucket]()
    
    init() {
        fetchOrderBuckets()
    }
    
    func fetchOrderBuckets() {
        Firestore.firestore().collection("orderBuckets").whereField("orderState", isEqualTo: "Pending").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.orderBuckets = documents.compactMap( {try? $0.data(as: OrderBucket.self) })
        }
    }

}
