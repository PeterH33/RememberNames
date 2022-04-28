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
   
    var body: some View {
        VStack{
            
            Image(uiImage: newImage)
                    .resizable()
                    .scaledToFit()
            
            TextField("Name", text: $newPerson.name)
            //TODO default the cursor to this text field and make hitting return execute the dismiss, also turn off suggestions and auto correct for this field
            Button{
                newPerson.photo = newImage
                people.people.append(newPerson)
                people.people.sort()
                //Dismiss View
                presentationMode.wrappedValue.dismiss()
                
            }label: {
                Text("Save Person")
                    .padding(20)
            }
            .contentShape(Rectangle())
            .disabled(newPerson.name == "")
        }
    }
}

//struct PersonNamerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonNamerView()
//    }
//}
