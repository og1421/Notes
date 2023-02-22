//
//  Settings.swift
//  Notes Watch App
//
//  Created by Orlando Moraes Martins on 21/02/23.
//

import SwiftUI

struct Settings: View {
    //MARK: - Properties
    @AppStorage("linecount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    //MARK: - Function
    func update() {
        lineCount = Int(value)
    }
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 8) {
            //HEADER
            HeaderView(title: "Settings")
            
            // ACTUAL LINE COUNT
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            //SLIDER
            Slider(value: Binding(get: {
                self.value
            }, set: { (newvValue) in
                self.value = newvValue
                self.update()
            }), in: 1...4, step: 1)
                .accentColor(.accentColor)
            
        }//:VSTACK
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
