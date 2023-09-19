//
//  TraitementRappel.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import SwiftUI

struct TraitementRappel: View {
    var medicamentProgramme = ["test","t"]
    var body: some View {
        List{
            ForEach(medicamentProgramme, id: \.self) { listMedicament in
                Section{
                    VStack {
                        HStack {
                            Image(systemName: "pills")
                                .font(.title)
                                .foregroundColor(.green)
                            
                            Text(listMedicament) // nom du medicament
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                        }.padding(.bottom, 1.0)
                        HStack{
                            Text("2 Fois par jour - 08:00 et 20:00")
                            Spacer()
                            
                        }
                        
                        HStack{
                            // nombre de comprimé dans la boite de medicament
                            Text("Il reste 1 Comprimé(s)")
                                .frame(width: 200.0, height: 34.0)
                                .font(.headline)
                                .background(.gray.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Spacer()
                            Image(systemName: "bell").font(.title).foregroundColor(.green)
                            
                        }
        
                        
                    }.padding(1.0)
                }
                }.frame(width:310, height: 150.0)
            
                
        }
        
        }
    }

struct TraitementRappel_Previews: PreviewProvider {
    static var previews: some View {
        TraitementRappel()
    }
}
