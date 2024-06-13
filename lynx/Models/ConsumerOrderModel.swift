//
//  ConsumerOrderModel.swift
//  lynx
//
//  Created by Andrew Tran on 7/10/22.
//

import SwiftUI

struct ConsumerOrderModel: View {
    let user: User
    var body: some View {
        VStack {
            HStack {
                // MARK: Replace with user's profile image
                Image("subwaybg").resizable().frame(width: 50, height: 50).clipShape(Circle())
                Text("\(user.firstname) \(user.lastname)").font(.system(size: 20, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
            Divider()
                .background(Color.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.trailing, 20)
                .padding(.leading, 20)
        }
    }
}

//struct ConsumerOrderModel_Previews: PreviewProvider {
//    static var previews: some View {
//        ConsumerOrderModel()
//    }
//}
