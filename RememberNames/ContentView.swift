//
//  ContentView.swift
//  RememberNames
//
//  Created by Peter Hartnett on 4/27/22.
//

import SwiftUI

struct ContentView: View {
    //image picker states
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var people: [Person] = [] //This will have to be loaded from data
    @State private var image: Image?
    
    var body: some View {
        NavigationView{
            List{
                
                ForEach(people) { person in
                    HStack{
                        Image("")
                            .resizable()
                            .frame(width: 104, height: 72)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .strokeBorder(.white, lineWidth: 1)
                            )
                            .accessibilityHidden(true)
                        Text(person.name)
                        // Small image of the person
                        //Persons name to the side of it
                    }
                }
                
            }
            .navigationTitle("Remember me!")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingImagePicker.toggle()
                    } label: {
                        Label("Add person", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in makeNewPerson() }
        }
        
    }
    
    
    
    func makeNewPerson() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
       //Make a new person
       let newPerson = Person(id: UUID(), name: "Fred", photo: "FredPic")
        people.append(newPerson)
        //Ask user for persons name
        //Save new person
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
