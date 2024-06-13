//
//  OrderInfoViewModel.swift
//  lynx
//
//  Created by Jeremy Suh on 8/20/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore



class OrderInfoViewModel: ObservableObject {
    var orderBucket: OrderBucket?
  
    
    func fetchBucket(order: Order) { 
    Firestore.firestore().collection("orderBuckets").document(order.orderBucket).getDocument { snapshot, _ in
        guard let orderBucket = try? snapshot?.data(as: OrderBucket.self) else {return}
        self.orderBucket = orderBucket
    }
    }
}
