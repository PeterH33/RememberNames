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
            Text("Name that person!")
            Button{
                newPerson.photo = newImage
                people.people.append(newPerson)
                //Dismiss View
                presentationMode.wrappedValue.dismiss()
                
            }label: {
                Text("Save Person")
            }
        }
    }
}

//struct PersonNamerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonNamerView()
//    }
//}
