//
//  PlusButton.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

struct PlusButton: View {
    @Binding var showCreateTicket: Bool
    
    var body: some View {
        
        Button(action: { self.showCreateTicket.toggle() }) {
        Image(systemName: "plus")
            .renderingMode(.original)
            .font(.system(size: 16, weight: .medium))
            .frame(width: 36, height: 36)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
        }

        
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton(showCreateTicket: .constant(false))
    }
}
