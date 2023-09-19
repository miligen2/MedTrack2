//
//  Traitement.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import SwiftUI
import UIKit


struct Traitement: View {
    
    @State var medicamentProgramme = []
    
    @State var isLinkActive = false
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                
                VStack {
                    if medicamentProgramme.isEmpty {
                        Text("Commençons !")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .padding(.bottom, 2.0)
                        
                        Text("Ajoutez votre premier traitement et recevez vos rappels")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 48.0)
                        
                        
                        Button {
                            self.isLinkActive = true
                        } label: {
                            Text("Ajouter un rappel")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(50)
                        }.navigationDestination(isPresented: $isLinkActive) {
                            addMedicament()
                        }
                        
                        
                        
                    } else {
                        TraitementRappel()
                    }
                }
                VStack{
                    HStack{
                        Text("Traitement")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    Spacer()
                }.padding()
            }
        }
        
    }
}




struct traitement_Previews: PreviewProvider {
    static var previews: some View {
        Traitement()
    }
}


struct addMedicament: View {
    
    var databaseManager = DatabaseManager()
    
    let medicaments: [Medicament] = [
        
        Medicament(
        id: 61266250,
        name: "A 313 200 000 UI POUR CENT, pommade"

    ),Medicament(
        id: 612,
        name: "REAR tEst pommade"
    ),
        Medicament(
        id: 616250,
        name: "Ctest, pommade"
    )
    ]
    @State private var searchText = ""
    @State private var selectedMedicament: Medicament? //transferer le medicament selectionné dans le navigation link

    var searchResults: [Medicament] {
            if searchText.isEmpty {
                return medicaments
            } else {
                return medicaments.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
    
    var body: some View{
        
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { medicament in
                    NavigationLink(destination: ProgrammationMed()){
                        HStack{
                            Image(systemName: "pill").foregroundColor(Color(hue: 0.313, saturation: 0.957, brightness: 0.627))
                            Text(medicament.name).font(.footnote)
                        }
                    }
                }
            }.listStyle(.plain).searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher un médicament")
                
        }.onAppear {
            //    medicaments = databaseManager.fetchDataMedicament()
           }

           
        }
        
    }
            
        

