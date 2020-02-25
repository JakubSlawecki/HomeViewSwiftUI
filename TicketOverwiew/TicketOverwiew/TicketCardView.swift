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
    @State var isSelected = false
    @EnvironmentObject var control: TicketCardView_Control
    
    var title: String
    var subtitle: String
    var briefSummary: String
    var description: String
    
    //MARK: normalCard state size
    let normalCardHeight: CGFloat = 350
    let normalCardHorizontalPadding: CGFloat = 20
    
    
    var body: some View {
        GeometryReader { geometry in
            TicketCardInnerView(isSelected: self.$isSelected,
                                title: self.title,
                                subtitle: self.subtitle,
                                briefSummary: self.briefSummary,
                                description: self.description,
                                normalCardHeight: self.normalCardHeight)
                .onTapGesture {
                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1)) {
                        self.isSelected.toggle()
                        self.control.anyTicketTriggered.toggle()
                    }
                }
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .shadow(color: Color.black.opacity(0.15), radius: 30, x: 0, y: 10)
            .offset(x: self.isSelected ? -geometry.frame(in: .global).minX : 0,
                    y: self.isSelected ? -geometry.frame(in: .global).minY : 0)
            .frame(height: self.isSelected ? screen.height : nil)
            .frame(width: self.isSelected ? screen.width : nil)
        }
        .frame(width: screen.width - (normalCardHorizontalPadding * 2))
        .frame(height: normalCardHeight)
        
        //.offset(y: control.anyTicketTriggered && !isSelected ? screen.height : 0)
        .opacity(control.anyTicketTriggered && !isSelected ? 0 : 1)
    }
}


#if DEBUG
struct TickedCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TickedCardView(isSelected: false,
                           title: "Apointment",
                           subtitle: "20.02.2020",
                           briefSummary: "Our technicians will be there on Monday 24 of Febuary 2020.",
                           description: desPlaceholer)
                
            .environmentObject(TicketCardView_Control())
            
            TopView(isSelected: .constant(false), title: "Apointment", subtitle: "20.02.2020", briefSummary: "Our technicians will be there on Monday 24 of Febuary 2020.")        }
    }
}
#endif

struct TicketCardInnerView: View {
    @Binding var isSelected: Bool
    
    var title: String
    var subtitle: String
    var briefSummary: String
    var description: String
    var normalCardHeight: CGFloat
    
    
    var body: some View {
        //GeometryReader { geometry in
            VStack {
                
                TopView(isSelected: self.$isSelected,
                        title: self.title,
                        subtitle: self.subtitle,
                        briefSummary: self.briefSummary)
                    .frame(height: self.normalCardHeight)
                    .background(
                        //putt image here or map?
                        //MapView()
                        
//                        VStack {
//                            Image("MapExample")
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(maxWidth: geometry.size.width,
//                                       maxHeight: geometry.size.height)
//    //                            .position(x: geometry.size.width / 2 ,
//    //                                      y:  geometry.size.height / 2 )
//    //                            .offset(y: geometry.frame(in: .global).minY / 2)
//                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
//                        }
                        Color.clear
                    )
                
                if self.isSelected {
                    ScrollView {
                        ExpandableView(isSelected: self.$isSelected, description: self.description)
                    }
                    .background(Color.white)
                }
                
            }
            .background(Color.white)
        //}
    }
}

struct TopView: View {
    @Binding var isSelected: Bool
    
    var title: String
    var subtitle: String
    var briefSummary: String
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
//                if self.isSelected {
//                    //Push content from safe area
//                    Rectangle()
//                        .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top)
//                        .frame(maxWidth: .infinity)
//                        .foregroundColor(Color.clear)
//                        .onTapGesture {
//                            print(geometry.safeAreaInsets.top)
//                        }
//                }
                
                
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


let screen = UIScreen.main.bounds

//Ticket to -> Card
struct Card : Identifiable {
    var id = UUID()
    
    var subtitle: String
    var title: String
    var briefSummary: String
    var description: String
}

//MARK: Fake Data
let desPlaceholer = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Enim eu turpis egestas pretium aenean pharetra magna ac. Quis enim lobortis scelerisque fermentum. Phasellus faucibus scelerisque eleifend donec pretium. Nec ullamcorper sit amet risus nullam eget. Convallis convallis tellus id interdum velit. A erat nam at lectus urna duis convallis convallis tellus. Id ornare arcu odio ut sem nulla pharetra diam sit. Cum sociis natoque penatibus et magnis. Viverra accumsan in nisl nisi scelerisque eu ultrices. Et netus et malesuada fames ac turpis egestas integer. Montes nascetur ridiculus mus mauris vitae ultricies leo. Sed felis eget velit aliquet sagittis id consectetur."

let cardData: [Card] = [
    Card(subtitle: "24.02.2020", title: "Apointment Confirmed", briefSummary: "Our technicians will be there on Wednesday February 26, 2020.", description: desPlaceholer),
    Card(subtitle: "21.02.2020", title: "Apointment Ongoing", briefSummary: "our technicians will be there on Monday February 24, 2020", description: desPlaceholer),
    Card(subtitle: "21.02.2020", title: "Apointment Done", briefSummary: "Job Done", description: desPlaceholer),
    Card(subtitle: "20.02.2020", title: "Apointment Done", briefSummary: "Job Done etc", description: desPlaceholer),
]
