//
//  DB.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import SQLite
import Foundation



//private func initContactsTable(db: Connection) throws {
//    let medicaments = Table("medicaments")
//    let id = Expression<Int64>("id")
//    let name = Expression<String?>("name")
//    let email = Expression<String>("email")
//
//    try db.run(medicaments.create { t in
//        t.column(id, primaryKey: true)
//        t.column(name)
//        t.column(email)
//    })
//}
//
//class DB_Manager {
//
//    private var db: Connection!
//
//    //table
//    private let medicament : Table
//    // colums de la table
//    private let id : Expression<Int>
//    private let name : Expression<String>
//
//    init() {
//
//        // creation table d'objets
//        medicament = Table("medicament")
//        id = Expression<Int>("id")
//        name = Expression<String>("name")
//        func start(){
//            do {
//                let fileURL = try! FileManager.default
//                    .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                    .appendingPathComponent("medicament.sqlite3")
//                //connection base de donnée
//                db = try Connection(fileURL.path)
//
//
//
//                // verification si la table est déja créé
//                if (!UserDefaults.standard.bool(forKey: "is_db_created")){
//                    //si non créé la table
//                    try db.run(medicament.create{(t) in
//                        t.column(id,primaryKey: true)
//                        t.column(name)
//                    })
//                    print("db created")
//
//                    UserDefaults.standard.set(true, forKey:"is_db_created")
//
//                }else{
//                    print("db always created ")
//                }
//            }catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
//
//class DataAccess {
//
//    let id = Expression<Int64>("id")
//    let name = Expression<String?>("name")
//    let email = Expression<String>("email")
//
//    func createContact(medicaments: Medicament) -> Int64 {
//        do {
//            let db = try Connection(fileName())
//
//            let contacts = Table("contacts");
//
//            let rowId = try db.run(contacts.insert(
//                name <- medicaments.name,
//                id <- medicaments.id))
//
//            return rowId
//
//        } catch {
//            print("ERROR: \(error)")
//        }
//        return -1
//    }
//
//    func fileName() -> String {
//        let path = NSSearchPathForDirectoriesInDomains(
//            .documentDirectory, .userDomainMask, true
//        ).first!
//
//        let name = "\(path)/db.sqlite3";
//        return name;
//    }
//
//    func initTables() {
//        do {
//            let db = try Connection(fileName())
//
//            try initContactsTable(db: db)
//
//        } catch {
//            print("ERROR: \(error)")
//        }
//    }
//
//    func dropTables() {
//        do {
//            let db = try Connection(fileName())
//
//            let medicaments = Table("medicaments");
//            try db.run(medicaments.drop(ifExists: true));
//
//        } catch {
//            print("ERROR: \(error)")
//        }
//    }
//
//    private func initMedicamentsTable(db: Connection) throws {
//        let medicaments = Table("medicaments")
//        let id = Expression<Int64>("id")
//        let name = Expression<String?>("name")
//
//        try db.run(medicaments.create { t in
//            t.column(id, primaryKey: true)
//            t.column(name)
//        })
//    }
//
//}
//

struct DatabaseManager {
     private var db: Connection!
    
    // The path to the SQLite database (storage location)
    private let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    init() {
        // Initialize the database (creates the SQLite file if it doesn't exist)
        do {
            db = try Connection("\(dbPath)/mydatabase.sqlite3")
        } catch {
            print("Error initializing the database: \(error)")
        }
    }
    
    func fetchDataMedicament() throws -> [Medicament] {
         
         var fetchMedicament: [Medicament] = []
         guard db != nil else {
             throw NSError(domain: "DatabaseManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Database not initialized."])
         }
         
         do{
             let query = Table("medicaments")
             
             let id = Expression<Int64>("id")
             let name = Expression<String>("name")
             
             if let rows = try? db.prepare(query) {
                   for row in rows {
                       let medicament = Medicament(id: row[id], name: row[name])
                       fetchMedicament.append(medicament)
                   }
               }
             return fetchMedicament
         }
     }
     
    
    
    func saveDataTakePill(nombreDeFoisParJour: Int,heureDePrise: Date, heureDePrise2: Date, heureDePrise3: Date, nombreDeComprimes: Int) throws {
        guard db != nil else {
            throw NSError(domain: "DatabaseManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Database not initialized."])
        }
        
        do {
            let pillsProgramme = Table("pillsProgrammé")
        
            let id = Expression<UUID>("id")
            let nmbFois = Expression<Int>("nmbFois")
            let heureDePrise = Expression<Date>("heureDePrise")
            let heureDePrise2 = Expression<Date>("heureDePrise2")
            let heureDePrise3 = Expression<Date>("heureDePrise3")
            let nmbPills = Expression<Int>("nmbPills")
            
            let uuid = UUID()// Générez un nouvel identifiant UUID pour chaque enregistrement
            
            let statement = pillsProgramme.create { t in
                            t.column(id, primaryKey: true)
                            t.column(nmbFois)
                            t.column(heureDePrise)
                            t.column(heureDePrise2)
                            t.column(heureDePrise3)
                            t.column(nmbPills)
                        }
            
            let insert = pillsProgramme.insert(
                id <- uuid,
                nmbFois <- Int(nombreDeFoisParJour),
                heureDePrise <- heureDePrise,
                heureDePrise2 <- heureDePrise2,
                heureDePrise3 <- heureDePrise3,
                nmbPills <- nmbPills)
            
            print(insert)
            
            try db?.run(statement)
        } catch {
            throw error
        }
    }
    
    
    
    
    
    func saveDataPill(nombreDeComprimesDansBoite: Int, rappelComprimes: Int) throws {
        guard db != nil else {
            throw NSError(domain: "DatabaseManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Database not initialized."])
        }
        
        do {
            let rappelProgramme = Table("rappelPillsProgramme")
        
            let id = Expression<UUID>("id")
            let comprimes = Expression<Int>("comprimes")
            let rappel = Expression<Int>("rappel")
            
            let uuid = UUID()// Générez un nouvel identifiant UUID pour chaque enregistrement
            
            let statement = rappelProgramme.create { t in
                            t.column(id, primaryKey: true)
                            t.column(comprimes, unique: true )
                            t.column(rappel)
                        }
            
            let insert = rappelProgramme.insert(id <- uuid,
                                      comprimes <- nombreDeComprimesDansBoite,
                                      rappel <- rappelComprimes)
            
            print(insert)
            
            try db?.run(statement)
        } catch {
            throw error
        }
    }
}
