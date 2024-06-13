//
//  OnboardingContent.swift
//  lynx
//
//  Created by Arnav Wadehra on 6/14/22.
//

import Foundation

struct Page : Identifiable {
    var id : Int
    var image : String
    var title : String
    var descrip : String
}

var Data = [
    Page(id: 0, image: "Wt1", title: "Consumer Discounts", descrip: "Join orders from your dropoff location to earn discounts on delivery prices!"),
    Page(id: 1, image: "Wt2", title: "Courier Earnings", descrip: "Already walking around grounds? Earn more as a courier by taking group orders to a single dropoff location."),
    Page(id: 2, image: "Wt3", title: "Restaurants", descrip: "Avoid making restaurants pay extra commission & service fees to companies like DoorDash & Grubhub. Lynx helps local restaurants.")
]
