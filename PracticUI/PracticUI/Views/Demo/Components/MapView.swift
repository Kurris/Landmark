//
//  MapView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/13.
//

import SwiftUI
import Inject
import MapKit
import CoreLocation
import CoreLocationUI

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    
    @ObserveInjection var inject

    
    @StateObject var locationManager = LocationManager()
    
    let annotations = [
            City(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
            City(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
            City(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
            City(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
        ]
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $locationManager.region
                ,showsUserLocation: true,userTrackingMode: .constant(.follow)
                ,annotationItems: annotations){ city in
//                MapPin(coordinate: city.coordinate)
//                MapMarker(coordinate: city.coordinate)
                MapAnnotation(coordinate: city.coordinate) {
                    Circle()
                           .strokeBorder(.red, lineWidth: 4)
                           .frame(width: 40, height: 40)
                }
            }
            .edgesIgnoringSafeArea(.all)
                
            
          VStack {
            if let location = locationManager.location {
                Text("**Current location:** \(location.latitude), \(location.longitude)")
                    .font(.callout)
                    .foregroundColor(.white)
                    .padding()
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            Spacer()
            LocationButton {
                locationManager.requestLocation()
            }
            .frame(width: 180, height: 40)
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .padding()
        }
        .enableInjection()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion(
           center: CLLocationCoordinate2D(latitude: 42.0422448, longitude: -102.0079053),
           span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        DispatchQueue.main.async {
            self.location = location.coordinate
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
