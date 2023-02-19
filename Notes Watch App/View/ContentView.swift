//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Orlando Moraes Martins on 18/02/23.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    //MARK: - Function
    func save() {
        dump(notes)
    }
    
    //MARK: - body
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6){
                TextField("Add New note", text: $text)
                
                Button{
                    // 1. Only runs the button action when the text field iis not empty
                    guard text.isEmpty == false else {
                        return
                    }
                    // 2. Create a new note item and initialize it with the text value
                    let note = Note(id: UUID(), text: text)
                    
                    // 3. add the new note item to the note array
                    notes.append(note)
                    
                    // 4. Make the text field empty
                    text = ""
                    
                    // 5. Save the notes
                    save()
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
//                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
            }//: HSTACK
            
            Spacer()
            
            Text("\(notes.count)")
        }//: Vstack
        .navigationTitle("Notes")
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
