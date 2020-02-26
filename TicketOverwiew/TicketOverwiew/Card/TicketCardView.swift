//
//  TicketCellView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 21/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

class TicketCardView_Control: ObservableObject {
    @Published var anyTicketTriggered = false
}

struct TickedCardView: View {
    @EnvironmentObject var control: TicketCardView_Control
    @State var isDetectingLongPress = false
    @State var isSelected = false
    
    
    var longPressAndRelese: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { longPress in
                withAnimation(.easeIn(duration: 0.15)) {
                    self.isDetectingLongPress = true
                }
            }
            .onEnded { finished in
                    self.isDetectingLongPress = false
                
                withAnimation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1)) {
                    self.isSelected = true
                    self.control.anyTicketTriggered = true
                }
            }
    }
    
    var press: some Gesture {
        TapGesture()
            .onEnded { finished in
                withAnimation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1)) {
                    self.isSelected = true
                    self.control.anyTicketTriggered = true
                    }
            }
    }
    
    
    var title: String
    var subtitle: String
    var briefSummary: String
    var description: String
    
    //MARK: normalCard state size
    let normalCardHeight: CGFloat = 350
    let normalCardHorizontalPadding: CGFloat = 20
    
    
    var body: some View {
        GeometryReader { geometry in
            CardView(isSelected: self.$isSelected,
                     title: self.title,
                     subtitle: self.subtitle,
                     briefSummary: self.briefSummary,
                     description: self.description,
                     normalCardHeight: self.normalCardHeight)
                
                .environmentObject(self.control)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 30, x: 0, y: 10)
                .offset(x: self.isSelected ? -geometry.frame(in: .global).minX : 0,
                        y: self.isSelected ? -geometry.frame(in: .global).minY : 0)
                .scaleEffect(self.isDetectingLongPress ? 0.95 : 1)
                
                //To do make it work together and with scrollView
                .gesture(self.press)
                .gesture(self.longPressAndRelese)
                
                .frame(height: self.isSelected ? screen.height : nil)
                .frame(width: self.isSelected ? screen.width : nil)
                
        }
        
            .frame(width: screen.width - (normalCardHorizontalPadding * 2))
            .frame(height: normalCardHeight)
            .opacity(control.anyTicketTriggered && !isSelected ? 0 : 1)
            .blur(radius: control.anyTicketTriggered && !isSelected ? 20 : 0)
    }
    
}


struct TickedCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            TickedCardView(isSelected: false, title: "Apointment", subtitle: "20.02.2020", briefSummary: "Our technicians will be there on Monday 24 of Febuary 2020.", description: desPlaceholer)
                .environmentObject(TicketCardView_Control())
            
            CardView(isSelected: .constant(true), title: "Apointment", subtitle: "20.02.2020", briefSummary: "Our technicians will be there on Monday 24 of Febuary 2020.", description: desPlaceholer, normalCardHeight: CGFloat(350))
                .environmentObject(TicketCardView_Control())
        }
        
    }
}


struct CardView: View {
    @EnvironmentObject var control: TicketCardView_Control
    @Binding var isSelected: Bool
    @State var viewState = CGSize.zero
    
    var dragSelectedCard: some Gesture {
        DragGesture()
            .onChanged { value in
                self.viewState = value.translation
            }
            .onEnded { value in
                self.viewState = .zero
            }
    }
    
    var title: String
    var subtitle: String
    var briefSummary: String
    var description: String
    var normalCardHeight: CGFloat
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                TopView(isSelected: self.$isSelected,
                        title: self.title,
                        subtitle: self.subtitle,
                        briefSummary: self.briefSummary)
                    
                    .environmentObject(self.control)
                    .frame(height: self.normalCardHeight)
                    //.background(Color.clear)
                
                if self.isSelected {
                    ExpandableView(isSelected: self.$isSelected, description: self.description)
                    
                    Spacer()
                }
                
            }
            .background(Color.white)
            .offset(y: self.isSelected ? self.viewState.height/2 : 0)
            .animation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1))
            .gesture(self.isSelected ? (self.dragSelectedCard) : (nil))
        }
        
    }
}

struct TopView: View {
    @EnvironmentObject var control: TicketCardView_Control
    @Binding var isSelected: Bool
    
    var title: String
    var subtitle: String
    var briefSummary: String
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Spacer()
                    if self.isSelected {
                        Button(action: {
                            withAnimation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1)) {
                                self.isSelected = false
                                self.control.anyTicketTriggered = false
                            }
                            
                            })
                        {
                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.original)
                            .font(.system(size: 30, weight: .medium))
                            .opacity(0.7)
                        }
                    }
                    
                    
                }
                .edgesIgnoringSafeArea(.top)
                .padding(.top, 40)
                .padding(.trailing, 25)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.subtitle)
                            .font(.caption)
                            .foregroundColor(.black)
                            .lineLimit(1)
                        
                        Text(self.title)
                            .font(.headline)
                            .foregroundColor(.black)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                }
                .padding(.leading)
                
                
                
                HStack(alignment: .center) {
                    Text(self.briefSummary)
                        .foregroundColor(.black)
                        .font(.caption)
                        .lineLimit(3)
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct ExpandableView: View {
    @Binding var isSelected: Bool
    
    var description: String
    

    var body: some View {
        Text(self.description)
            .font(.body)
            .foregroundColor(.black)
            .padding()
    }
}


