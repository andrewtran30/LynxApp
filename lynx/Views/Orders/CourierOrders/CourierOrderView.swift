//
//  CourierOrderView.swift
//  lynx
//
//  Created by Jeremy Suh on 7/13/22.
//
import SwiftUI

struct CourierOrderView: View {
    @ObservedObject var viewModel = CourierOrdersViewModel()
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    Text("Courier Orders")
                        .font(.custom("Avenir", size: 45))
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                        .padding(.top, 15)
                    Button(action: {
                        viewModel.fetchOrder()
                        viewModel.filterOrders()
                        viewModel.fetchCompletedBuckets()
                    }, label: {
                        Image(systemName: "arrow.clockwise")
//                        print("Orders are being refreshed...")
                    }).padding(.trailing, 15)
                }
                
                Divider()
                    .background(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 5)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
            }
            
            Group {
                ScrollView {
                    if(viewModel.buckets.count == 0) {
                        Text("You have no active orders!")
                    }
                    ForEach(viewModel.buckets) { bucket in
                        CourierOrderCard(bucket: bucket, status: "pending", viewModel: OrderBucketViewModel(orderBucket: bucket), viewModel2: viewModel)
                    }
                    Text("Completed Orders")
                        .font(.custom("Avenir", size: 30))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 15)
                    ForEach(viewModel.completedOrders) { bucket in
                        CourierOrderCard(bucket: bucket, status: "completed", viewModel: OrderBucketViewModel(orderBucket: bucket), viewModel2: viewModel)
                    }
                    Divider()
                        .background(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.trailing, 20)
                        .padding(.leading, 20)
                    // For each OrderCellModel --> produce all of them
                }
            }

        }.onAppear {
            viewModel.fetchOrder()
            viewModel.fetchCompletedBuckets()
            viewModel.filterOrders()
        }
    }
}
