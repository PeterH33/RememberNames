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
                if let unwrappedPhoto = person.photo{
                    Image(uiImage: unwrappedPhoto)
                        .resizable()
                        .scaledToFit()
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
