//
//  UserModel.swift
//  lynx
//
//  Created by Jeremy Suh on 6/22/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    var email:String
    var phonenumber:String
    var firstname:String
    var username:String?
    var lastname:String
    var gender:String?
    var balance:Int
    var classyear: String
    var venmo: String 
    var courierBalance:Int
    @DocumentID var id: String?
    

}

struct ApplicationModel: Identifiable, Decodable {
    var app: Bool
    @DocumentID var id: String?
    
}
