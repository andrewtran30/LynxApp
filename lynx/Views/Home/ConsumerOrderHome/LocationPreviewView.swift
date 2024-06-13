//
//  LocationPreviewView.swift
//  lynx
//
//  Created by Andrew Tran on 8/8/22.
//

import SwiftUI

struct LocationPreviewView: View {
    let user: User
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    @Binding var selectedTab: MainTabView.Tab
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            VStack(spacing: 8) {
                confirmDeliveryButton
//                nextButton
            }
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial).offset(y: 65)).cornerRadius(10)

    }
}

//struct LocationPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.green.ignoresSafeArea()
//            LocationPreviewView(location: LocationsDataService.locations.first!)
//                .padding()
//        }.environmentObject(LocationsViewModel())
//    }
//}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.address)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var confirmDeliveryButton: some View {
        NavigationLink {
            HomeView(user: user, deliveryAddress: location.name, location: location, selectedTab: $selectedTab)
        } label: {
            Text("Confirm Dropoff")
                .font(.headline)
                .frame(width: 140, height: 35)
        }.buttonStyle(.borderedProminent)

        
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 180, height: 35 )
        }.buttonStyle(.bordered)
    }
}
