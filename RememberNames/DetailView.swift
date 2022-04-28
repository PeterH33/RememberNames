//
//  DetailView.swift
//  RememberNames
//
//  Created by Peter Hartnett on 4/27/22.
//

import SwiftUI

struct DetailView: View {
    let person : Person
    
    
    
    var body: some View {
        Form{
            VStack{
                Text(person.name)
                if let unwrappedURL = person.photo{
                    if let unwrappedUIImage = person.loadImage(url: unwrappedURL) {
                        Image(uiImage: unwrappedUIImage)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(person: Person())
//    }
//}
