//
//  Chart.getTopArtists.swift
//  ReScrobbler
//
//  Created on 11.06.2021.
//

class getTopArtists {
    struct jsonStruct: Codable {
        let artists: Artists?
    }
    
    // MARK: - Artists
    struct Artists: Codable {
        let artist: [Artist]?
        let attr: Attr?
        
        enum CodingKeys: String, CodingKey {
            case artist
            case attr = "@attr"
        }
    }
    
    // MARK: - Artist
    struct Artist: Codable {
        let name, playcount, listeners, mbid: String?
        let url: String?
        let streamable: String?
        let image: [Image]?
    }
    
    // MARK: - Image
    struct Image: Codable {
        let text: String?
        let size: Size?
        
        enum CodingKeys: String, CodingKey {
            case text = "#text"
            case size
        }
    }
    
    enum Size: String, Codable {
        case extralarge = "extralarge"
        case large = "large"
        case medium = "medium"
        case mega = "mega"
        case small = "small"
    }
    
    // MARK: - Attr
    struct Attr: Codable {
        let page, perPage, totalPages, total: String?
    }
}
