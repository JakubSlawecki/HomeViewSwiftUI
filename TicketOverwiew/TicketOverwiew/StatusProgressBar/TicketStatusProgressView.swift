//
//  TicketStatusProgressView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 24/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

enum ProgressBarState {
    case created, accepted, onsite, completed
}

struct TicketStatusProgressView: View {
    @State var state: ProgressBarState = .created
    
    var body: some View {
            ZStack {
                VStack {
                    VStack(alignment: .center) {
                        progres()
                    }
                    .frame(height: 80)
                        
                    .background(Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(1), radius: 5, x: 0, y: -6)
                    .shadow(color: Color(#colorLiteral(red: 0.7136986852, green: 0.6937760711, blue: 0.662347436, alpha: 1)).opacity(0.4), radius: 4, x: 0, y: 4)
                    .overlay( //white border
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3977686216)), lineWidth: 1))
                }
            }
            .padding(.horizontal, 20)
    }
    
    func progres() -> some View {
        switch state {
        case .created:
            return AnyView(ProgressBar(currentProgress: 0)).id("ProgressBar")
        case .accepted:
            return AnyView(ProgressBar(currentProgress: 0.33)).id("ProgressBar")
        case .onsite:
            return AnyView(ProgressBar(currentProgress: 0.66)).id("ProgressBar")
        case .completed:
            return AnyView(ProgressBar(currentProgress: 1)).id("ProgressBar")
        }
    }
    
}

struct TicketStatusProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TicketStatusProgressView(state: .accepted)
    }
}



struct ProgressBar: View {
    @State var currentProgress: CGFloat
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                ZStack {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray).opacity(0.5)
                            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(1),
                                    radius: 1, x: -1, y: -1)
                        
                        Rectangle()
                            .frame(width: geometry.size.width * self.currentProgress, height: 3)
                            .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(1), radius: 5, x: -0.5, y: -0.4)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.06), radius: 1, x: 0.5, y: 0.5)
                    }
                    
                    
                    Group {
                        StatusCircle(state: self.currentProgress == 0 ? .active : .finished, text: "CREATED")
                            .offset(x: -geometry.size.width/2,
                                    y: geometry.size.height/8)
                        
                        StatusCircle(state:
                            self.currentProgress == 0.33 ? .active : self.currentProgress > 0.33 ? .finished : .unactive, text: "ACCEPTED")
                            .offset(x: -geometry.size.width/6.6,
                                    y: geometry.size.height/8)

                        StatusCircle(state:
                            self.currentProgress == 0.66 ? .active : self.currentProgress > 0.66 ? .finished : .unactive, text: " ONSITE ")
                            .offset(x: geometry.size.width/6.6,
                                    y: geometry.size.height/8)

                        StatusCircle(state:
                            self.currentProgress == 1 ? .active : .unactive, text: "FINISH")
                            .offset(x: geometry.size.width/2,
                                    y: geometry.size.height/8)
                    }
                            
                }
            }
        }
        .padding(.horizontal, 40)
    
    }
}
