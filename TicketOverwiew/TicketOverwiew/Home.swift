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
    
    var body: some View {
        ZStack {
            NavigationView {
                HomeView()
                    .navigationBarTitle("Ticket Overview")
                    .navigationBarItems(trailing:
                        PlusButton(showCreateTicket: $showCreateTicket)
                    )
            }
            
            TestView(showCreateTicket: $showCreateTicket)
                .offset(y: showCreateTicket ? 0 : screen.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
