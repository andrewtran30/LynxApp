//
//  LocationsListView.swift
//  lynx
//
//  Created by Andrew Tran on 8/8/22.
//

import SwiftUI

struct LocationsListView: View {
    let searched: String
    @EnvironmentObject private var vm: LocationsViewModel
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                if (searched == "") {
                    Button {
                        vm.showNextLocation(location: location)
                    } label: {
                        listRowView(location: location)
                    }
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
                }
                else if (location.name.localizedCaseInsensitiveContains(searched) || location.address.localizedCaseInsensitiveContains(searched)) {
                    Button {
                        vm.showNextLocation(location: location)
                    } label: {
                        listRowView(location: location)
                            
                    }
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

extension LocationsListView {
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.address)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView(searched: "Search")
            .environmentObject(LocationsViewModel())
    }
}


