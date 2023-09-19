//
//  ProgrammationMedSecondView.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import SwiftUI

struct ProgrammationMedSecondView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var remindMe = true
    
    @State private var nombreDeComprimesDansBoite = 30
    @State private var rappelComprimes = 10
    
    @State private var showNotification1 = false
    @State private var showNotification2 = false
    
    @State private var text1 = ""
    @State private var text2 = ""
    
    @State private var vibrateOnRing = true
    
    @State private var saveRappel = true
    var databaseManager = DatabaseManager()
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                
                HStack{
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left.circle.fill").font(.largeTitle).padding()
                    }
                    Spacer()
                }
                
                Image("Rappel_icone")
                
                Text("Souhaitez-vous recevoir des rappels pour renouveler votre stock du medicament ?")
                    .font(.title2)
                    .fontWeight(.medium)
                
                HStack{
                                   Toggle("Rappelez-moi", isOn: $remindMe)
                               }.padding().background().cornerRadius(10).padding(.horizontal, 20)
                
                HStack{
                    Text("Quantité")
                    Spacer()
                    Button("\(nombreDeComprimesDansBoite) Comprimé(s)"){
                        showNotification1 = true
                    }.disabled(!remindMe).alert(Text("Quantités"), isPresented: $showNotification1) {
                        Button("Annuler",role: .cancel){
                            
                        }
                        Button("OK"){
                            if let newNombreDeComprimeDansBoite = Int(text1){
                                                         nombreDeComprimesDansBoite = newNombreDeComprimeDansBoite
                                                     }
                        }
                        TextField("\(nombreDeComprimesDansBoite)",text: $text1).keyboardType(.numberPad)
                    }  message: {
                        Text("Comprimé(s)")
                    }
                }.padding().background().cornerRadius(10).padding(.horizontal, 20)
                
                HStack{
                    Text("Quand il reste")
                    Spacer()
                    Button("\(rappelComprimes) Comprimé(s)") {
                        showNotification2 = true
                    }.disabled(!remindMe).alert(Text("Quantités"), isPresented: $showNotification2) {
                        Button("Annuler",role: .cancel){
                            
                        }
                        Button("OK"){
                            if let newRappelComprime = Int(text2) {
                                                           rappelComprimes = newRappelComprime
                                                       }
                        }
                        TextField("\(rappelComprimes)",text: $text2).keyboardType(.numberPad)
                    } message: {
                        Text("Comprimé(s)")
                    }
                }.padding().background().cornerRadius(10).padding(.horizontal, 20.0)
                
                
                Spacer()
                
                ProgressView(value: 0.75).padding(20)
                
                Button(action: {
                    if remindMe{
                                            saveDataToDatabase()
                                        }else{
                                            presentationMode.wrappedValue.dismiss()
                                        }
                }, label:  {
                    Text("Enregistrer").padding(.horizontal, 120.0).padding(.vertical).background(Color.accentColor).cornerRadius(10)
                        .fontWeight(.black)
                        .foregroundColor(Color.white)
                }).onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
                
            }.background(Color(red: 0.922, green: 0.922, blue: 0.922))
        }.navigationBarBackButtonHidden(true)

    }
    
    private func saveDataToDatabase() {
         do {

             // Enregistrer les données dans lta base de données
             try databaseManager.saveDataPill(nombreDeComprimesDansBoite: nombreDeComprimesDansBoite, rappelComprimes: rappelComprimes)
             

             
             // Mettre à jour l'interface utilisateur ou effectuer d'autres actions si nécessaire
         } catch {
             print("Erreur lors de l'enregistrement des données dans la base de données : \(error)")
         }
     }
}





struct ProgrammationMedSecondView_Previews: PreviewProvider {
    static var previews: some View {
        ProgrammationMedSecondView()
    }
}
