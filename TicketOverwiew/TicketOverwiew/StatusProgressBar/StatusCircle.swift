//
//  StatusCircle.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 24/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

enum StatusCircleState {
    case unactive, active, finished
}

struct StatusCircle: View {
    @State var state: StatusCircleState
    var text: String
    
    var body: some View {
        
        VStack {
            containedView()
        }

        
    }
    func containedView() -> AnyView {
        switch state {
        case .unactive:
            return AnyView(UnactiveCircle(text: self.text))
        case .active:
            return AnyView(ActiveCircle(text: self.text))
        case .finished:
            return AnyView(FinishedCircle(text: self.text))
        
        }
    }
}

struct StatusCircle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            StatusCircle(state: .finished, text: "CREATED")
            StatusCircle(state: .active, text: "ACCEPTED")
            StatusCircle(state: .unactive, text: "ONSITE")
        }
        
    }
}


struct UnactiveCircle: View {
    var text: String
    
    var body: some View {
        
            VStack {
                
                ZStack {
                    Circle()
                    .frame(width: 5, height: 5)
                        .foregroundColor(Color.gray)
                        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.3), radius: 2, x: -0.5, y: -0.5)
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.3), radius: 1, x: 0.5, y: 0.5)
                    .padding(5)
                    
                }
                
                Text(self.text)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 10))
            }
           
        
    }
}

struct ActiveCircle: View {
    var text: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.431372549, blue: 0.2274509804, alpha: 1)))
                    //.shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.9), radius: 2, x: -0.2, y: -0.5)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.4), radius: 1, x: 0.5, y: 0.5)
                
                Circle()
                .frame(width: 5, height: 5)
                    .foregroundColor(Color(#colorLiteral(red: 0.8892078996, green: 0.8839221597, blue: 0.893271029, alpha: 1)))
                .padding(5)
                
                    
            }
            Text(self.text)
            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.431372549, blue: 0.2274509804, alpha: 1)))
            .font(.system(size: 10))
        }
        
        
    }
}

struct FinishedCircle: View {
    var text: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.431372549, blue: 0.2274509804, alpha: 1)))
                .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.3), radius: 2, x: -0.5, y: -0.5)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.3), radius: 1, x: 0.5, y: 0.5)
                
                Circle()
                .frame(width: 4, height: 4)
                    .foregroundColor(Color(#colorLiteral(red: 0.8892078996, green: 0.8839221597, blue: 0.893271029, alpha: 1)))
                .padding(5)
            }
            
            Text(self.text)
            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.431372549, blue: 0.2274509804, alpha: 1)))
            .font(.system(size: 10))
        }
    }
}
