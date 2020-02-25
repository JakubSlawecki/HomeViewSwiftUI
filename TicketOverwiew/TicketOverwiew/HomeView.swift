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
        
        ScrollView {
            TopMenu(showCreateTicket: $showCreateTicket)
                .padding(.horizontal, 20)
                .padding(.top, 10)
               //.padding(.bottom, 5)
            
            ForEach(self.tickets) { ticked in
                TickedCardView (
                    title: ticked.title,
                    subtitle: ticked.subtitle,
                    briefSummary: ticked.briefSummary,
                    description: ticked.description
                )
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

struct TopMenu: View {
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





