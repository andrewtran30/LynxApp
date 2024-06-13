//
//  OrderBucketCellView.swift
//  lynx
//
//  Created by Jeremy Suh on 7/13/22.
//

import SwiftUI

struct OrderBucketCellView: View {
    var body: some View {
        VStack {
            HStack {
                Image("subwaybg").resizable().frame(width: 50, height: 50).clipShape(Circle())
                Text("Subway").font(.system(size: 20, design: .default))
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

