//
//  ModalMedicament.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import Foundation

struct Medicament:Identifiable,Hashable {
    let id : Int64
    let name : String
}

struct StoredData{
    let nombreDeFoisParJour: Int
    let heureDePrise: Date
    let heureDePrise2: Date
    let heureDePrise3: Date
    let nombreDeComprimes: Int
}
