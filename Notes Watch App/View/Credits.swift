//
//  Credits.swift
//  Notes Watch App
//
//  Created by Orlando Moraes Martins on 20/02/23.
//

import SwiftUI

struct Credits: View {
    //MARK: - Properties
    @State private var randomNumber: Int = Int.random(in: 1..<4)
    
    private var randomImage: String {
        return "developer-no\(randomNumber)"
    }
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 3) {
            // Profile image
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            // header
            HeaderView(title: "Credits")
            
            // Content
            Text("Orlando Gabriel")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
        }//: VSTACK
    }
}

struct Credits_Previews: PreviewProvider {
    static var previews: some View {
        Credits()
    }
}
