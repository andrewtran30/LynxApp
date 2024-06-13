//
//  Location.swift
//  lynx
//
//  Created by Andrew Tran on 8/8/22.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Equatable {
    let name: String
    let address: String
    let coordinates: CLLocationCoordinate2D
    let imageName: String
    
    var id: String {
        name + address
    }
    
    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
