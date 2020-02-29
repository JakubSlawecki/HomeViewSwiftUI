//
//  SystemMaterialView.swift
//  TicketOverwiew
//
//  Created by Jakub Slawecki on 25/02/2020.
//  Copyright © 2020 Jakub Slawecki. All rights reserved.
//

import SwiftUI

struct SystemMaterialView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<SystemMaterialView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<SystemMaterialView>) {

    }

}


struct SystemMaterialView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ZStack {
                VStack {
                    HStack {
                        Color.white
                            
                      
                    }
                    .padding(.horizontal)
                    
                   
                    .padding(.horizontal)
                }
            
                
                SystemMaterialView(style: .systemUltraThinMaterial)
                    .frame(width: 200, height: 200)
                    .environment(\.colorScheme, .light)
            }
            
            ZStack {
                VStack {
                    
                    
                    HStack {
                        Color.black
                            
                      
                    }
                    .padding(.horizontal)
                }
            
                
                SystemMaterialView(style: .regular)
                    .frame(width: 200, height: 200)
                .environment(\.colorScheme, .dark)
            }
        }
    }
}
