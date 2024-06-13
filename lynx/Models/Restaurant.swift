//
//  Restaurant.swift
//  lynx
//
//  Created by Jeremy Suh on 6/26/22.
//

import Foundation
import Foundation
import FirebaseFirestoreSwift

struct Restaurant: Identifiable, Decodable {
    @DocumentID var id: String?
    var restaurantName: String
    var restaurantLogo: String
    var restaurantWebsite: String
    var restaurantPhoneNumber: String
    var restaurantAddress: String
}

