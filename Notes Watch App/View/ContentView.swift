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
    
    func getDocumentsDirectory () -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
//        dump(notes)
        do {
            // 1. Convert the notes array data using JSON encoder
            let data = try JSONEncoder().encode(notes)
            
            // 2. Create a new URL to save the file using getDocumentsDirectory
            let url = getDocumentsDirectory().appendingPathComponent("notes")
            
            // 3. Write data to givem URL
            try data.write(to: url)
            
        } catch {
            print("Saving data has failed")
        }
    }
    
    func load () {
        DispatchQueue.main.async {
            do {
                // 1. get the notes URL path
                let url = getDocumentsDirectory().appendingPathComponent("notes")
                
                // 2. Create a new property for the data
                let data = try Data(contentsOf: url)
                
                // 3. Decode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
                
            } catch {
                // do nothing
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    //MARK: - body
    var body: some View {
        NavigationView {
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
                
                if notes.count >= 1 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { note in
                            NavigationLink(destination: DetailView(note: notes[note], count: notes.count, index: note)) {
                              HStack {
                                Capsule()
                                  .frame(width: 4)
                                  .foregroundColor(.accentColor)
                                Text(notes[note].text)
                                  .lineLimit(1)
                                  .padding(.leading, 5)
                              }
                            } //: HSTACK
                        } //: LOOP
                        .onDelete(perform: delete)
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(25)
                    Spacer()
                }//:LIST
            }//: Vstack
            .navigationTitle("Notes")
            .onAppear(perform: {
                load()
        })
        }
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
