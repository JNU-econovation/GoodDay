//
//  File.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/10.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

class GDMissionData {
    let db = Firestore.firestore()
    
    static let shared = GDMissionData()

    private init() {}
    
    func getMissionData() -> [Mission] {
        let path = Bundle.main.path(forResource: "missionContent", ofType: "json")
        
        let data = try? String(contentsOfFile: path!).data(using: .utf8)
        let json = try! JSONDecoder().decode([Mission].self, from: data!)
         
        return json
    }
      
    func getMissionPerDay() -> MissionPerDay? {
        
        var result: MissionPerDay?
        
        let docRef = db.collection("missionPerDay").document((UserDefaults.standard.string(forKey: "userUid"))!)
                
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                do {
                    let json = try JSONSerialization.data(withJSONObject: data!, options: [])
                    result = try JSONDecoder().decode(MissionPerDay.self, from: json)
                } catch {
                    print("getMissionPerDay(): error")
                }
            } else {
                print("Document does not exist")
            }
        }

        return result
    }
    
    func putMissionPerDay(uid: String, week: Int, day: Int, missionId: Int, isSuccess: Bool) {
    }
    
    func dictionaryToObject<T:Decodable>(objectType:T.Type,dictionary:[[String:Any]]) -> [T]? {
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode([T].self, from: dictionaries) else { return nil }
        return objects
    }
}

struct Mission: Codable {
    var id: Int
    var detail: String
    var tags: String
    var content: String
    var EI: String
    var SN: String
    var TF: String
    var JP: String
}

struct MissionPerDay: Codable {
    var weeks: [MissionWeek]
}

struct MissionWeek: Codable {
    var id: Int
    var days: [MissionDay]
}

struct MissionDay: Codable {
    var id: Int
    var missionId: Int
    var isSuccess: Int
}

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
