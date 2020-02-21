//
//  TicketCellView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

struct TicketCellView: View {
    @State var showDetailTicket = false
    
    var ticket: Ticket
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(ticket.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color.black)
                Spacer()
            }
            Text(ticket.text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(#colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.6156862745, alpha: 1)))
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: self.showDetailTicket ? detailCellWidth : cellWidth, height: self.showDetailTicket ? detailCellHeight : cellHeight)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.15), radius: 30, x: 0, y: 10)
        .animation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0))
        .onTapGesture {
                self.showDetailTicket.toggle()
        }
    }

}

struct TicketCellView_Previews: PreviewProvider {
    static var previews: some View {
        TicketCellView(ticket: Ticket(title: "Ticket", text: "ticket body"))
    }
}

let cellWidth = screen.width * 0.9
let cellHeight = screen.height * 0.4

let detailCellWidth = screen.width * 0.95
let detailCellHeight = screen.height * 0.8
