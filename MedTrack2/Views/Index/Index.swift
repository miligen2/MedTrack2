//
//  Index.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import SwiftUI

struct Index: View {
    @State var button = false
    @State var medicamentProgramme = []

    
    var body: some View {
        ZStack {
            VStack {
                if medicamentProgramme.isEmpty {
                    //                    ZStack {
                    //                        Image("MEDTRACK2")
                    //                            .resizable()
                    //                            .frame(width: 200, height: 200)
                    //                            .opacity(0.40)
                    //                    }
                    VStack {
                        Text("Visualisez vos traitement")
                            .font(.title2)
                            .foregroundColor(.green)
                            .padding(.bottom, 2.0)
                        Text("Visualisez facilement les traitements que vous devez prendre planifiés dans Traitement")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 48.0)
                            .foregroundColor(.gray)
                        
                    }
                    .padding(.top, 50)
                } else {
                    IndexRappel()
                }
            }
            VStack{
                HStack{
                    Text("À prendre 💊")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                Spacer()
            }.padding()
        }
    }
}


struct index_Previews: PreviewProvider {
    static var previews: some View {
        Index()
    }
}
