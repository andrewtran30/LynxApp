//
//  CurrentOrderCell.swift
//  lynx
//
//  Created by Jeremy Suh on 6/27/22.
//

import SwiftUI
import Firebase

struct CurrentOrderCell: View {
//    var pickupLocation: String
//    var dropoffLocation: String
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeLeft = ""
    @Binding var selectedTab: MainTabView.Tab
    let orderBucket: OrderBucket
    let user: User
    let location: Location
    
//    init(user: User, orderBucket: OrderBucket) {
//        self.orderBucket = orderBucket
//        self.user = user
//        tvm.start(minutes: Float(orderBucket.timeCreated.seconds))
//    }
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading) {
                Text(orderBucket.restaurantName)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.top, 15)
                Text("To: \(orderBucket.destination)")
                    .font(.system(size: 13, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                Text("Delivery Fee: $\(orderBucket.deliveryCost + 2.0, specifier: "%.2f")")
                    .font(.system(size: 13, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                    .padding(.bottom, 15)
                Text("Remaining Time: \(timeLeft)")
                    .font(.system(size: 13, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                    .padding(.bottom, 15)
                    .onReceive(timer) { _ in
                        updateCounter()
                }
            }.padding(.leading, 15)
            Spacer()
            NavigationLink(destination: JoinOrderView(location1: location, order: orderBucket, user: user, selectedTab: $selectedTab)) {
                Text("**Join Order**")
                    .font(.system(size: 12, weight: .bold, design: .default))
                    .padding(12)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(100)
            }.padding(.trailing, 15)
        }
        .frame(maxWidth: .infinity, alignment: .center)
                .background(Color("lynxPurple"))
                .modifier(CardModifier())
                .frame(width: UIScreen.main.bounds.width - 30)
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let date = orderBucket.timeCreated.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        // Convert Date to String
        let string = dateFormatter.string(from: date)
        return string
    }
    
    func updateCounter() {
        var timeNow: String
        let curr = Timestamp(date: Date())
        let left = 600 - (curr - orderBucket.timeCreated)
        let seconds = left % 60
        let minutes = left / 60
        if (left <= 0) {
            self.timeLeft = "0:00"
        } else {
            self.timeLeft = String(format: "%d:%02d", minutes, seconds)
        }
    }
    
    var lefttime: String {
        let currTime = Timestamp(date: Date())
        let time: String
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.second, .minute]
//        formatter.maximumUnitCount = 1
//        formatter.unitsStyle = .abbreviated
        let left = 600 - (currTime - orderBucket.timeCreated)
        let seconds = left % 60
        let minutes = left / 60
        if (left <= 0) {
            time = "0:00"
        } else {
            time = String(format: "%d:%02d", minutes, seconds)
        }
        return time
    }
    
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}
