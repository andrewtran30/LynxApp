//
//  RestaurantCardView.swift
//  lynx
//
//  Created by Jeremy Suh on 6/29/22.
//

import SwiftUI

struct RestaurantCardView: View {
    let restaurantName: String
    let restaurantLogo: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(SwiftUI.Color.gray, lineWidth: 1)
                .frame(width: cardAndImageWidth, height: cardHeight)
                .background(SwiftUI.Color.white)
            VStack(alignment: .leading, spacing: 10) {
                Image("\(restaurantLogo)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cardAndImageWidth - 2, height: imageHeight - 2)
                    .clipped()
                    .frame(alignment: .center)
                    .padding(.top, 1)
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(restaurantName)")
                        .font(.custom("Avenir", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color("lynxPurple"))
                    Text("Order until 8:00 PM!")
                        .font(.custom("Avenir", size: 14))
                        .foregroundColor(SwiftUI.Color.gray)
                        .padding(.bottom, 10)
                }
                .padding(.horizontal,12)
                .padding(.bottom,11)
            }
            .frame(width: cardAndImageWidth, height: cardHeight)
            .cornerRadius(cornerRadius)
        }
    }
    private let cardAndImageWidth: CGFloat = UIScreen.main.bounds.width - 30
    private let cardHeight: CGFloat = UIScreen.main.bounds.height / 4
    private let imageHeight: CGFloat = (UIScreen.main.bounds.height / 4) * 0.75
    private let cornerRadius: CGFloat = 10
}
