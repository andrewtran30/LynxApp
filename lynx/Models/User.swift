//
//  User.swift
//  lynx
//
//  Created by Jeremy Suh on 6/15/22.
//

import Foundation
import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    
    @DocumentID var id: String?
    var email:String
    
}
