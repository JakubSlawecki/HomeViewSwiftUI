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
                
                Circle()
                .frame(width: 5, height: 5)
                    .foregroundColor(Color.white)
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
                
                Circle()
                .frame(width: 5, height: 5)
                    .foregroundColor(Color.white)
                .padding(5)
            }
            
            Text(self.text)
            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.431372549, blue: 0.2274509804, alpha: 1)))
            .font(.system(size: 10))
        }
    }
}
