//
//  jsonTagGetInfo.swift
//  ReScrobbler
//
//  Created by Mac on 08.10.2021.
//

class jsonTagGetInfo{
    // MARK: - Welcome
    struct jsonStruct: Codable {
        let tag: Tag?
    }
    
    // MARK: - Tag
    struct Tag: Codable {
        let name: String?
        let total, reach: Int?
        let wiki: Wiki?
    }
    
    // MARK: - Wiki
    struct Wiki: Codable {
        let summary, content: String?
    }
}
