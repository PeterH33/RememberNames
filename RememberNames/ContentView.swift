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
    @State private var showingDetailView = false
    @State private var showingNewPersonNamer = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    //@State private var people: [Person] = [] //This will have to be loaded from data
    // @State private var image: Image?
    @State private var newPerson = Person()
    @StateObject var people : People = People()
    
    func removeItems(at offsets: IndexSet) {
        people.people.remove(atOffsets: offsets)
    }
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(people.people) { person in
                    NavigationLink{
                        DetailView(person: person)
                    } label: {
                        
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
                        }//End Hstack
                    }//end label
                }//End foreach
                .onDelete(perform: removeItems)
                
                
            }//endlist
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
        
    }
    
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
