//
//  OrderBucket.swift
//  lynx
//
//  Created by Jeremy Suh on 6/26/22.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase

struct OrderBucket: Identifiable, Decodable {
    @DocumentID var id: String?
    
    var destination: String
    let timeCreated: Timestamp
    var numberOfOrders: Int
    var restaurantName: String
    var orderState: String
    var courier: String?
    var deliveryCost: Double
    var orderMult: Double 
}

