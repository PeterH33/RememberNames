//
//  ContentView.swift
//  RememberNames
//
//  Created by Peter Hartnett on 4/27/22.
//

import SwiftUI

class People: ObservableObject{
    @Published var people = [Person]()
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
    
    init() {
        do {
            //trys to load up the data from the save file path on initial load.
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            people = []
            print("Data failed to load or no data existed. loc People class init()")
        }
    }//end init
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
        //Add in a removal of the image file so that the documents directory dosnt bloat.
        do {
            let data = try JSONEncoder().encode(people.people)
            //Note .compelteFileprotection option encrypts the data so that it can only be read when the phone is unlocked. But alone it will not do anything if the phone is already unlocked and someone looks at the program, that requires an unlock screen in app
            try data.write(to: people.savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data. Loc ContentView.removeItems()")
        }
    }
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(people.people) { person in
                    NavigationLink{
                        DetailView(person: person)
                    } label: {
                        
                        HStack{
                            if let unwrappedURL = person.photo{
                                if let unwrappedUIImage = person.loadImage(url: unwrappedURL) {
                                    Image(uiImage: unwrappedUIImage)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )
                                        .accessibilityHidden(true)
                                    
                                    Spacer()
                                    Text(person.name)
                                }
                            }
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
    
    
    
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
