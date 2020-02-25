//
//  HomeView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var control: TicketCardView_Control
    @Binding var showCreateTicket: Bool
    //change cardData to real tickets
    var tickets = cardData
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            ScrollViewTitleView(showCreateTicket: $showCreateTicket)
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .blur(radius: control.anyTicketTriggered ? 20 : 0)
            
            ForEach(self.tickets) { ticked in
                    TickedCardView (title: ticked.title,
                                    subtitle: ticked.subtitle,
                                    briefSummary: ticked.briefSummary,
                                    description: ticked.description)
                        .environmentObject(self.control)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
            }
            
        }
    
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView(showCreateTicket: .constant(false))
            .environmentObject(TicketCardView_Control())
        
    }
    
}

struct ScrollViewTitleView: View {
    @Binding var showCreateTicket: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("WED, JULY 31")
                .font(.caption)
                .padding(.bottom, -10)
                .foregroundColor(.gray)
            
            HStack(alignment: .center) {
                Text("Tickets")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                
                ShowActionButton(systemSymbol: "plus") {
                    self.showCreateTicket.toggle()
                }
                
            }
            
        }
        
    }
    
}


//MARK: Fake Data

//Ticket to -> Card
struct Card : Identifiable {
    var id = UUID()
    
    var subtitle: String
    var title: String
    var briefSummary: String
    var description: String
}

let desPlaceholer = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Enim eu turpis egestas pretium aenean pharetra magna ac. Quis enim lobortis scelerisque fermentum. Phasellus faucibus scelerisque eleifend donec pretium. Nec ullamcorper sit amet risus nullam eget. Convallis convallis tellus id interdum velit."

let cardData: [Card] = [
    Card(subtitle: "24.02.2020", title: "Apointment Confirmed", briefSummary: "Our technicians will be there on Wednesday February 26, 2020.", description: desPlaceholer),
    Card(subtitle: "21.02.2020", title: "Apointment Ongoing", briefSummary: "our technicians will be there on Monday February 24, 2020", description: desPlaceholer),
    Card(subtitle: "21.02.2020", title: "Apointment Done", briefSummary: "Job Done", description: desPlaceholer),
    Card(subtitle: "20.02.2020", title: "Apointment Done", briefSummary: "Job Done etc", description: desPlaceholer),
]
