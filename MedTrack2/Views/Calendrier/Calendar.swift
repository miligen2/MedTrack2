//
//  Calendar.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import SwiftUI

struct Calendar: View {
   @State var medicamentProgramme = []
    @State var isLinkActivate = false
    var body: some View {
        ZStack{
            VStack{
                if medicamentProgramme.isEmpty{
                    VStack {
                        Text("Oops !")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.accentColor)
                            .padding(.bottom, 2.0)
                        
                        Text("Vous n'avez pas encore programmé de rappel ")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 48.0)
          
                    }
                }else{
                    DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                    
                    
                
                }
            }
            VStack{
                HStack{
                    Text("Calendrier")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                Spacer()
            }.padding()
        }

        
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}

struct CalendarIsFull: View {
    
    
    @State var selectedGraphique = false
    var body: some View {
        VStack{
            VStack{
                Picker("Picker", selection: $selectedGraphique) {
                    Text("Graphique").tag(false)
                    Text("Liste").tag(true)
                }.pickerStyle(.segmented).padding(.horizontal, 20 ).colorMultiply(Color("AccentColor"))
                
                
            }
        }
        
    }

}
