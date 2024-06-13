//
//  Card.swift
//  lynx
//
//  Created by Arnav Wadehra on 6/14/22.
//

import Foundation

struct Card : Identifiable {
    var id : Int
    var image : String
    var title : String
    var description : String
    var stars : Int
    var price = "$25.00"
    var expand : Bool
}

var TrendingCard = [
    Card(id: 0, image: "roots", title: "Roots", description: "Roots is great!",stars: 5, expand: false),
    Card(id: 1, image: "roots", title: "Roots", description: "Roots is great!",stars: 5, expand: false),
    Card(id: 2, image: "roots", title: "Roots", description: "Roots is great!",stars: 5, expand: false),
    Card(id: 3, image: "roots", title: "Roots", description: "Roots is great!",stars: 5, expand: false),
    Card(id: 4, image: "roots", title: "Roots", description: "Roots is great!",stars: 5, expand: false),
    Card(id: 5, image: "roots", title: "Roots", description: "Roots is great!",stars: 5, expand: false),
]

var FoodTypes = ["Pizza","Drinks","Tacos","Burger","Fries","Top"]
