//
//  PlusButton.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

struct ShowActionButton: View {
    //@Binding var showCreateTicket: Bool
    let systemSymbol: String
    let closure: () -> ()
    
    var body: some View {
        
        Button(action: { self.closure() }) {
        Image(systemName: systemSymbol)
            .renderingMode(.original)
            .font(.system(size: 16, weight: .medium))
            .frame(width: 36, height: 36)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
        }

        
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowActionButton(systemSymbol: "plus", closure: {})
    }
}
