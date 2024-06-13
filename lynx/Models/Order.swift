//
//  Order.swift
//  lynx
//
//  Created by Jeremy Suh on 6/27/22.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase

struct Order: Identifiable, Decodable {
    @DocumentID var id: String?
    
    var userUid: String 
    
    var customerName: String
    var customerPhone: String
    var deliveryDestination: String
    var deliveryInstructions: String
    var orderItem: String
    var orderNumber: String
    var restaurantName: String
    
    var deliveryCost: Double
    var tip: Double
    
    var orderBucket: String 
    
    let timestamp: Timestamp
}

