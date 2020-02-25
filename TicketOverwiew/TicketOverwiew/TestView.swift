//
//  TestView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI
import MapKit

struct TestView: View {
    @Binding var showCreateTicket: Bool
    
    var body: some View {
        
        ZStack {
            MapView()
                .edgesIgnoringSafeArea(.all)
            
        
                
                Button(action: { self.showCreateTicket = false }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            
        }
        
    }
}



struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(showCreateTicket: .constant(false))
    }
}


struct MapView: UIViewRepresentable {
  
  var locationManager = CLLocationManager()
  func setupManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
  }
  
  func makeUIView(context: Context) -> MKMapView {
    setupManager()
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
  }
}


struct BackButton: View {
    let label: String
    let closure: () -> ()

    var body: some View {
        Button(action: { self.closure() }) {
            HStack {
                Image(systemName: "chevron.left")
                Text(label)
            }
        }
    }
}
