//
//  ContentView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var showCreateTicket = false
    @ObservedObject var control = TicketCardView_Control()
    
    var body: some View {
        
        ZStack {
            NavigationView {
                
                HomeView(showCreateTicket: $showCreateTicket)
                    .navigationBarHidden(true)
                    .environmentObject(self.control)
                    .navigationBarTitle("Tickets")
                    .navigationBarItems(trailing:
                        NavigationLink(destination:
                            TestView(showCreateTicket: $showCreateTicket),
                                       isActive: $showCreateTicket,
                                       label: { EmptyView() })
                    )
                
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

let screen = UIScreen.main.bounds

