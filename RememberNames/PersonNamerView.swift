//
//  PersonNamerView.swift
//  RememberNames
//
//  Created by Peter Hartnett on 4/27/22.
//

import SwiftUI

struct PersonNamerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var newImage: UIImage
    @ObservedObject var people : People
    @State var newPerson = Person()
    
    
    let locationFetcher = LocationFetcher()
    
    
    func save() {
        
        if let location = self.locationFetcher.lastKnownLocation {
            newPerson.latitude = location.latitude
            newPerson.longitude = location.longitude
        } else {
            print("Location did not load for saving, loc PersonNamerView.save()")
        }
        
        
        
        //convert the UIimage to a jpeg and store it in the documents file directory under the UUID for the file name
        let photoFileName = FileManager.documentsDirectory.appendingPathComponent("\(newPerson.id).jpeg")
        if let jpegData = newImage.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: photoFileName, options: [.atomic, .completeFileProtection])
        }
        
        
        
        newPerson.photo = photoFileName
        people.people.append(newPerson)
        people.people.sort()
        
        do {
            let data = try JSONEncoder().encode(people.people)
            //Note .compelteFileprotection option encrypts the data so that it can only be read when the phone is unlocked. But alone it will not do anything if the phone is already unlocked and someone looks at the program, that requires an unlock screen in app
            try data.write(to: people.savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data. Location PersonNamerView save()")
        }
    }
    
    var body: some View {
        VStack{
            
            Image(uiImage: newImage)
                .resizable()
                .scaledToFit()
            
            TextField("Name", text: $newPerson.name)
            //TODO default the cursor to this text field and make hitting return execute the dismiss, also turn off suggestions and auto correct for this field
            Button{
                save()
                //Dismiss View
                presentationMode.wrappedValue.dismiss()
                
            }label: {
                Text("Save Person")
                    .padding(20)
            }
            .contentShape(Rectangle())
            .disabled(newPerson.name == "")
        }
        .onAppear(perform: self.locationFetcher.start)
    }
}

//struct PersonNamerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonNamerView()
//    }
//}
