//
//  ContentView.swift
//  RememberNames
//
//  Created by Peter Hartnett on 4/27/22.
//

import SwiftUI

class People: ObservableObject{
    @Published var people = [Person]()
}

struct ContentView: View {
    //image picker states
    @State private var showingNewPersonNamer = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    //@State private var people: [Person] = [] //This will have to be loaded from data
    @State private var image: Image?
    @State private var newPerson = Person()
    @StateObject var people : People = People()
    
    
    
    var body: some View {
        NavigationView{
            List{
                
                ForEach(people.people) { person in
                    HStack{
                        if let unwrapped = person.photo{
                            Image(uiImage: unwrapped)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                                .accessibilityHidden(true)
                        }
                        Spacer()
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
            .onChange(of: inputImage) { _ in
                
                showingNewPersonNamer.toggle()
            }
            .sheet(isPresented: $showingNewPersonNamer){
                //need to unwrap the inputImage and send it over
                if let newImage = inputImage{
                    PersonNamerView(newImage: newImage, people: people)
                }
            }
        }
        
    }
    
    func save(){
        print("Save function ******")
        //people.people.append(newPerson)
        //This dosnt work because I am not changing anything with the person namer view, I want that view to create the new person and then send it back here to be added to the list
    }
    
    func makeNewPerson() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
       //Make a new person
     //  let newPerson = Person(id: UUID(), name: "Fred", photo: "FredPic")
     //   people.append(newPerson)
        //Ask user for persons name
        //Save new person
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
