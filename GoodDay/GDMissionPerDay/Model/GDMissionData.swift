//
//  File.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/10.
//

import Foundation
import Firebase

class GDMissionData {
    let db = Firestore.firestore()
    var missionPerDayData: MissionPerDay?
    
    init() {
        missionPerDayData = getMissionPerDay()
    }
    
    func getMissionData() -> [Mission] {
        let path = Bundle.main.path(forResource: "missionContent", ofType: "json")
        
        let data = try? String(contentsOfFile: path!).data(using: .utf8)
        let json = try! JSONDecoder().decode([Mission].self, from: data!)
        
        return json
    }
    
    func getMissionPerDay() -> MissionPerDay? {
        let docRef = db.collection("missionPerDay").document("1234")
        
        var data: [String:Any]?
        var result: MissionPerDay?
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                data = document.data()
            } else {
                print("Document does not exist")
            }
            
            do {
                let json = try JSONSerialization.data(withJSONObject: data!, options: [])
                result = try JSONDecoder().decode(MissionPerDay.self, from: json)
            } catch {
                print("getMissionPerDay(): error")
            }
        }
        
        return result
    }
    
    func putMissionPerDay(uid: String, week: Int, day: Int, missionId: Int, isSuccess: Bool) {
        var isChange = false
        
        missionPerDayData?.weeks.forEach{ (oneWeek) in
            if oneWeek.id == week {
                oneWeek.days.forEach{ (oneDay) in
                    if oneDay.id == day { // 기존에 있던 미션
                        missionPerDayData?.weeks[week-1].days[missionId-1].missionId = missionId
                        missionPerDayData?.weeks[week-1].days[missionId-1].isSuccess = isSuccess
                        isChange = true
                        return
                    }
                }
                if isChange {
                    return
                } else { // 새로운 날의 미션
                    let missionDay = MissionDay(id: day, missionId: missionId, isSuccess: isSuccess)
                    missionPerDayData?.weeks[week-1].days.append(missionDay)
                    isChange = true
                }
            }
        }
        if !isChange { //새로운 주의 미션
            let missionWeek = MissionWeek(id: week, days: [MissionDay.init(id: day, missionId: missionId, isSuccess: isSuccess)])
            missionPerDayData?.weeks.append(missionWeek)
            isChange = true
        }
        
        db.collection("missionPerDay").document(uid).setData( try! missionPerDayData?.toDictionary() as! [String : Any]) { err in
            if let err = err {
                print("Err writing document: \(err)")
            } else {
                print("Document successfully written!: week\(week), day\(day), missionId\(missionId)")
            }
        }
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
    var isSuccess: Bool
}

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
