//
//  jsonUserGetInfo.swift
//  ReScrobbler
//
//  Created by Mac on 17.09.2021.
//

class jsonUserGetInfo{
    
    // MARK: - Welcome
    struct jsonStruct: Codable {
        let user: User?
    }
    
    // MARK: - User
    struct User: Codable {
        let playlists, playcount, gender, name: String?
        let subscriber: String?
        let url: String?
        let country: String?
        let image: [Image]?
        let registered: Registered?
        let type, age, bootstrap, realname: String?
    }
    
    // MARK: - Image
    struct Image: Codable {
        let size: String?
        let text: String?
        
        enum CodingKeys: String, CodingKey {
            case size
            case text = "#text"
        }
    }
    
    // MARK: - Registered
    struct Registered: Codable {
        let unixtime: String?
        let text: Int?
        
        enum CodingKeys: String, CodingKey {
            case unixtime
            case text = "#text"
        }
    }
    
    
}
