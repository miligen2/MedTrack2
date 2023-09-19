//
//  ContentView.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            //page d'accueil ou on retrouve les medicaments à prendre
            Index()
                .tabItem {
                Label("À prendre", systemImage: "checklist.checked")
            }
            // Permets de pouvoir parametre un reveil mettre les traitements dans index
                Traitement()
                .tabItem {
                    Label("Traitement", systemImage: "pill.fill")
                }
            // rappel sur un calendrier sur la prise de medicament
                Calendar()
                .tabItem {
                    Label("Calendrier", systemImage: "calendar")
                }
            // Chat intégerer pour pouvoir parler avec un médecin
//                Chat()
//                .tabItem{
//                    Label("Chat", systemImage: "ellipsis.message")
//                }
      }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
