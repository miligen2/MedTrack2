//
//  ProgrammationMed.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import SwiftUI

struct ProgrammationMed: View {
    
    @Environment(\.presentationMode) var presentationMode

    @State private var nombreDeFoisParJour = 1
    @State private var heureDePrise = Date()
    @State private var heureDePrise2 = Date()
    @State private var heureDePrise3 = Date()
    
    @State private var nombreDeComprimes = 1
    
    @State var isPresented = false
    
    var databaseManager = DatabaseManager()
    
    var body: some View {
        NavigationView{
        VStack{
            HStack{
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left.circle.fill").font(.largeTitle).padding()
                }
                Spacer()
            }
            
            Image("pills").resizable().frame(width: 180.0, height: 120.0).scaledToFit()
            
            Text("À quelle fréquence prenez-vous ce médicament ?").font(.title2)
                .fontWeight(.medium)
            
            HStack{
                Text("Nombre de fois par jour")
                    .font(.callout)
                Spacer()
                Stepper(value: $nombreDeFoisParJour, in: 1...3, step: 1) {
                    Text("\(nombreDeFoisParJour) ").padding(.leading, 20.0)
                }
            }.padding().background().cornerRadius(10).padding(.horizontal, 20.0)
            
            HStack{
                Text("Heure de prise")
                Spacer()
                DatePicker("", selection: $heureDePrise, displayedComponents: .hourAndMinute)
                    .datePickerStyle(DefaultDatePickerStyle())
            }.padding().background().cornerRadius(10).padding(.horizontal, 20.0)
            
            if nombreDeFoisParJour == 2{
                HStack{
                    Text("Heure de prise")
                    Spacer()
                    DatePicker("", selection: $heureDePrise2, displayedComponents: .hourAndMinute)
                        .datePickerStyle(DefaultDatePickerStyle())
                }.padding().background().cornerRadius(10).padding(.horizontal, 20.0)
                
            } else if nombreDeFoisParJour == 3{
                HStack{
                    Text("Heure de prise")
                    Spacer()
                    DatePicker("", selection: $heureDePrise2, displayedComponents: .hourAndMinute)
                        .datePickerStyle(DefaultDatePickerStyle())
                }.padding().background().cornerRadius(10).padding(.horizontal, 20.0)
                
                HStack{
                    Text("Heure de prise")
                    Spacer()
                    DatePicker("", selection: $heureDePrise3, displayedComponents: .hourAndMinute)
                        .datePickerStyle(DefaultDatePickerStyle())
                    
                }.padding().background().cornerRadius(10).padding(.horizontal, 20.0)
                
            }
            
            
            HStack{
                Text("Nombre de comprimés")
                Spacer()
                Stepper(value: $nombreDeComprimes, in: 1...9, step: 1) {
                    Text("\(nombreDeComprimes) ").padding(.leading, 40.0)
                }
            }.padding().background().cornerRadius(10).padding(.horizontal, 20.0)
            
            Spacer()
            ProgressView(value: 0.5).padding(20)
            
            Button(action: {
                self.isPresented = true
                saveDataToDatabase()
            }, label: {
                Text("Suivant").padding(.horizontal, 120.0).padding(.vertical).background(Color.accentColor).cornerRadius(10)
                    .fontWeight(.black)
                    .foregroundColor(Color.white)
            }).navigationDestination(isPresented: $isPresented) {
                ProgrammationMedSecondView()
            }


            
            
            
        }.background(Color(red: 0.922, green: 0.922, blue: 0.922))
    }.navigationBarBackButtonHidden(true)

        
    }
    
    
    private func saveDataToDatabase() {
         do {

             // Enregistrer les données dans lta base de données
             try databaseManager.saveDataTakePill(nombreDeFoisParJour: nombreDeFoisParJour, heureDePrise: heureDePrise, heureDePrise2: heureDePrise2, heureDePrise3: heureDePrise3, nombreDeComprimes: nombreDeComprimes)

             
             // Mettre à jour l'interface utilisateur ou effectuer d'autres actions si nécessaire
         } catch {
             print("Erreur lors de l'enregistrement des données dans la base de données : \(error)")
         }
     }
    }

   

struct ProgrammationMed_Previews: PreviewProvider {
    static var previews: some View {
        ProgrammationMed()
    }
}

