//
//  DetailView.swift
//  RememberNames
//
//  Created by Peter Hartnett on 4/27/22.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let person : Person
    @ObservedObject var people : People
    
    //Binding for where the map starts, oriented around lat and long in the person, also the point where the drop pin goes
    @State  var mapRegion : MKCoordinateRegion
    @State  var personLocation : [CLLocationCoordinate2D] = []
    
  
    
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
                }//end image if let
                
                
                
                //This is going to bring up pins with everyone that was met, kinda a fun idea...
                Map(coordinateRegion: $mapRegion, annotationItems: people.people) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "mappin")
                                .foregroundColor(.red)
                            Text(location.name)
                        }
                    }
                }
                
                
            }//end vstack
            
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(person: Person())
//    }
//}
