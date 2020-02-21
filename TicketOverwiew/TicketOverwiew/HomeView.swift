//
//  HomeView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                HStack {
                    Spacer()
                    
                    VStack(spacing: 30) {
                        TicketCellView(ticket: Ticket(title: "Dummy ticket", text: "body"))
                        TicketCellView(ticket: Ticket(title: "Dummy ticket2", text: "body"))
                        TicketCellView(ticket: Ticket(title: "Dummy ticket3", text: "body"))
                        TicketCellView(ticket: Ticket(title: "Dummy ticket4", text: "body"))
                        TicketCellView(ticket: Ticket(title: "Dummy ticket5", text: "body"))
                        TicketCellView(ticket: Ticket(title: "Dummy ticket6", text: "body"))
                    }
                    
                    Spacer()
                }
//                VStack(spacing: 30) {
//                    ForEach(sectionData) { ticket in
//
//                        TicketCellView(ticket: ticket)
//
//
//
//
//
//                    }
//                }
//                .padding(30)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


let screen = UIScreen.main.bounds


let sectionData = [
    Ticket(title: "First Ticket", text: "title Ticket"),
    Ticket(title: "Second Ticket", text: "title Ticket"),
    Ticket(title: "Third Ticket", text: "title Ticket"),
    Ticket(title: "Fourth Ticket", text: "titl Ticket "),
    Ticket(title: "Fifth Ticket", text: "title Ticket")
]

struct Ticket: Identifiable {
    var id = UUID()
    
    var title: String
    var text: String
}

