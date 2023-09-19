//
//  IndexRappel.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import SwiftUI

struct IndexRappel: View {
    var medicamentProgramme = ["oui","test","ok"]
    
    
    var body: some View {
        List{
            ForEach(medicamentProgramme, id: \.self) { listMedicament in
                Section{
                    VStack {
                        HStack{
                            Text("8h00")
                                .font(.headline)
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "pills")
                                .font(.title)
                                .foregroundColor(Color.accentColor)
                            
                            Text(listMedicament)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                        }
                        .padding()
                        
                        
                        
                        HStack{Text("1 Comprimé(s)")
                            .font(.headline)
                            Spacer()
                        }.padding(.leading)
                        
                        
                        Rectangle()
                            .fill(Color.accentColor)
                            .frame(height: 2)
                            .padding(.vertical)
                        
                        HStack{
                            Spacer()
                                           Button(action: {}){
                                               HStack{
                                                   Image(systemName: "xmark")
                                                   Text("Skip")
                                               }
                                           }
                                           
                                           Spacer()
                                           
                                           Button(action: {}){
                                               HStack{
                                                   Image(systemName: "checkmark")
                                                   Text("Done")
                                               }
                                           }
                                           Spacer()
                        }.padding(.bottom, 10)


                    }
                    
                }
    
                    
                }            }


        }
}

struct IndexRappel_Previews: PreviewProvider {
    static var previews: some View {
        IndexRappel()
    }
}
