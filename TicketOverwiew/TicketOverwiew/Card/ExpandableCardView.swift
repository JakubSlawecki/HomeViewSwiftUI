//
//  ExpandableCardView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

class TicketCardView_Control: ObservableObject {
    @Published var anyTicketTriggered = false
}

struct ExpandableCardView: View {
    @EnvironmentObject var control: TicketCardView_Control
    @State var viewState = CGSize.zero
    @State var isDetectingLongPress = false
    @State var isSelected = false
    
    var ticket: Ticket
    
    //MARK: Card size
    let normalCardHeight: CGFloat = 350
    let normalCardHorizontalPadding: CGFloat = 20

    let openCardAnimation = Animation.timingCurve(0.7, -0.35, 0.2, 0.9, duration: 0.45)
    
    //MARK: Gestures
    var press: some Gesture {
        TapGesture()
            .onEnded { finished in
                withAnimation(self.openCardAnimation) {
                    self.isDetectingLongPress = true
                    self.isSelected = true
                    self.control.anyTicketTriggered = true
                    self.isDetectingLongPress = false
                }
            }
    }
    
    var longPressAndRelese: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { _ in
                withAnimation(.easeIn(duration: 0.15)) {
                    self.isDetectingLongPress = true
               }
            }
            .onEnded { _ in
                withAnimation(self.openCardAnimation) {
                    self.isSelected = true
                    self.control.anyTicketTriggered = true
                    self.isDetectingLongPress = false
                }
            }
    }

    var dragSelectedCard: some Gesture {
        DragGesture()
            .onChanged { value in
                self.viewState = value.translation
            }
            .onEnded { value in
                self.viewState = .zero
            }
    }

    
    //MARK: View Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    TopView(isSelected: self.$isSelected,
                            ticket: self.ticket)
                        .environmentObject(self.control)
                        .frame(height: self.normalCardHeight)
                    
                    if self.isSelected {
                        ExpandableView(isSelected: self.$isSelected, ticket: self.ticket)
                        
                        Spacer()
                    }
                } //VStack
                .background(Color.white.opacity(0.01))
                .offset(y: self.isSelected ? self.viewState.height/2 : 0)
                .animation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1))
                .gesture(self.isSelected ? (self.dragSelectedCard) : (nil))
            } //ZStack
            .drawingGroup() //test it
                
            //MARK: Card Appearance
            .background(Color(.secondarySystemGroupedBackground))
            .environmentObject(self.control)
            .clipShape(RoundedRectangle(cornerRadius: self.isSelected ? 0 : 15, style: .continuous))
            .shadow(color: Color.black.opacity(0.15), radius: 30, x: 0, y: 10)
            .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 7)
            
            //MARK: Animation end effect (globa/local)
            .scaleEffect(self.isDetectingLongPress ? 0.95 : 1)
///           to test on preview change (in: .global) to (in: .local)
///            .offset(x: self.isSelected ? -geometry.frame(in: .local).minX : 0,
///                 y: self.isSelected ? -geometry.frame(in: .local).minY : 0)
            .offset(x: self.isSelected ? -geometry.frame(in: .global).minX : 0,
                    y: self.isSelected ? -geometry.frame(in: .global).minY : 0)
            
            .frame(height: self.isSelected ? screen.height : nil)
            .frame(width: self.isSelected ? screen.width : nil)
            
            .gesture(self.press)
            .gesture(self.longPressAndRelese)
        } //GeometryReader
        .frame(width: screen.width - (normalCardHorizontalPadding * 2))
        .frame(height: normalCardHeight)
            
        //MARK: Appearance of other Cards when the selected Card opens
        .opacity(control.anyTicketTriggered && !isSelected ? 0 : 1)
        .blur(radius: control.anyTicketTriggered && !isSelected ? 20 : 0)
    }

}


//MARK: TopView

struct TopView: View {
    @EnvironmentObject var control: TicketCardView_Control
    @Binding var isSelected: Bool
    
    var ticket: Ticket
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                if self.isSelected {
                    Rectangle()
                        .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.clear)
                }
                
                //MARK: Upper part
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.ticket.subtitle)
                            .font(.caption)
                            .foregroundColor(Color(.label))
                            .lineLimit(1)
                        
                        Text(self.ticket.title)
                            .font(.headline)
                            .foregroundColor(Color(.label))
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    if self.isSelected {
                        Button(action: {
                            withAnimation(Animation.timingCurve(0.7, -0.35, 0.2, 0.9, duration: 0.45)) {
                                self.isSelected = false
                                self.control.anyTicketTriggered = false }}) {
                                    Image(systemName: "xmark.circle.fill").foregroundColor(Color(.label))
                                        .font(.system(size: 30, weight: .medium))
                                        .opacity(0.7)
                        }
                    }
                } //HStack
                .padding(.top)
                .padding(.horizontal)
                
                
                Spacer()
                //MARK: Middle part
                Spacer()
                
                
                //MARK: Bottom part
                HStack(alignment: .center) {
                    Text(self.ticket.briefSummary)
                        .foregroundColor(Color(.label))
                        .font(.caption)
                        .lineLimit(3)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}

//MARK: BottomView

struct ExpandableView: View {
    @Binding var isSelected: Bool
    
    var ticket: Ticket
    
    
    var body: some View {
        Text(self.ticket.description)
            .font(.body)
            .foregroundColor(Color(.label))
            .padding()
    }
}




//MARK: Preview
struct TickedCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ExpandableCardView(isSelected: false, ticket: Ticket(subtitle: "20.02.2020", title: "Apointment", briefSummary: "Our technicians will be there on Monday 24 of Febuary 2020.", description: desPlaceholer))
                .environmentObject(TicketCardView_Control())
            .environment(\.colorScheme, .light)
            
            ExpandableCardView(isSelected: false, ticket: Ticket(subtitle: "20.02.2020", title: "Apointment", briefSummary: "Our technicians will be there on Monday 24 of Febuary 2020.", description: desPlaceholer))
                    .environmentObject(TicketCardView_Control())
                .environment(\.colorScheme, .dark)
        }
    }
}
