//
//  SetDeliveryView.swift
//  lynx
//
//  Created by Andrew Tran on 7/6/22.
//

import SwiftUI
import Combine
import CoreLocation
import MapKit

struct SetDeliveryView: View {
    @EnvironmentObject var viewModel: MainViewModel
    let user: User
    @EnvironmentObject private var vm: LocationsViewModel
    @State var searchText = ""
    @Binding var selectedTab: MainTabView.Tab
    
    var body: some View {
        ZStack {
            mapLayer
            VStack {
                header.padding()
                
                Spacer()
                locationsPreviewStack
            }
            
        }.navigationTitle("Select a Dropoff Location")
    }
}

extension SetDeliveryView {
    private var header: some View {
        VStack(spacing: 0) {
            
            TextField("Select a Delivery Point", text: $searchText)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .padding(.leading, 15)
                .animation(.none, value: vm.mapLocation)
                .foregroundColor(.primary)
                .overlay(alignment: .trailing, content: {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                })
                .onTapGesture {
                    vm.toggleLocationsList()
                }
//            Button(action: vm.toggleLocationsList) {
//                Text(vm.mapLocation.name)
//                    .font(.title2)
//                    .fontWeight(.black)
//                    .foregroundColor(.primary)
//                    .frame(height: 55)
//                    .frame(maxWidth: .infinity)
//                    .animation(.none, value: vm.mapLocation)
//                    .overlay(alignment: .leading) {
//                        Image(systemName: "arrow.down")
//                            .font(.headline)
//                            .foregroundColor(.primary)
//                            .padding()
//                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
//                    }
//            }
            if vm.showLocationsList {
                LocationsListView(searched: searchText)
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        }
    }
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(user: user, location: location, selectedTab: $selectedTab)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}


// struct SetDeliveryView_Previews: PreviewProvider {
//     static var previews: some View {
//         SetDeliveryView()
//     }
// }



//       ScrollView {
//        VStack {
//                Text("Hoos Hungry?")
//                    .font(.system(size: 44, weight: .heavy, design: .default))
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .padding(.bottom, 1)
//
//                Section {
//    //                    Image("location-img")
//                        TextField("Dropoff Address", text: $mapSearch.searchTerm).font(.system(size: 18))
//                        .padding(10)
//                        .background(Color(.secondarySystemBackground))
//                        .cornerRadius(10)
//                        .overlay(RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.gray, lineWidth: 1))
//                        .padding(.vertical, 12)
//                        .frame(width: UIScreen.main.bounds.width - 30)
//
//                        if address != mapSearch.searchTerm && isFocused == false {
//                        ForEach(mapSearch.locationResults, id: \.self) { location in
//                            Button {
//                                reverseGeo(location: location)
//                            } label: {
//                                ScrollView {
//                                    Text(location.title)
//    //                                    .foregroundColor(Color.white)
//                                    Text(location.subtitle)
//                                        .font(.system(.caption))
//    //                                    .foregroundColor(Color.white)
//                                }
//                            }
//                        }
//                    }
//                }
//                .listRowSeparator(.visible)
//
//
//                NavigationLink {
//                    HomeView(user: user, deliveryAddress: mapSearch.searchTerm)
//                } label: {
//                    Text("Search").font(.system(size: 20, weight: .bold))
//                        .font(Font.headline.weight(.heavy))
//                        .padding(.horizontal, 100)
//                        .padding(.vertical, 12)
//                        .foregroundColor(.white)
//                        .background(Color("lynxPurple"))
//                        .cornerRadius(100)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 100)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
//                }
////
//            }
//        }



//    @StateObject private var mapSearch = MapSearch()
//
//    func reverseGeo(location: MKLocalSearchCompletion) {
//        let searchRequest = MKLocalSearch.Request(completion: location)
//        let search = MKLocalSearch(request: searchRequest)
//        var coordinateK : CLLocationCoordinate2D?
//        search.start { (response, error) in
//        if error == nil, let coordinate = response?.mapItems.first?.placemark.coordinate {
//            coordinateK = coordinate
//        }
//
//        if let c = coordinateK {
//            let location = CLLocation(latitude: c.latitude, longitude: c.longitude)
//            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//
//            guard let placemark = placemarks?.first else {
//                let errorString = error?.localizedDescription ?? "Unexpected Error"
//                print("Unable to reverse geocode the given location. Error: \(errorString)")
//                return
//            }
//
//            let reversedGeoLocation = ReversedGeoLocation(with: placemark)
//
//            address = "\(reversedGeoLocation.streetNumber) \(reversedGeoLocation.streetName)"
//            city = "\(reversedGeoLocation.city)"
//            state = "\(reversedGeoLocation.state)"
//            zip = "\(reversedGeoLocation.zipCode)"
//            mapSearch.searchTerm = address
//            isFocused = false
//
//                }
//            }
//        }
//    }
//
//    let user: User
//    @EnvironmentObject var viewModel: MainViewModel
//
//    @FocusState private var isFocused: Bool
//
//    @State private var btnHover = false
//    @State private var isBtnActive = false
//
//    @State private var address = ""
//    @State private var city = ""
//    @State private var state = ""
//    @State private var zip = ""

    
