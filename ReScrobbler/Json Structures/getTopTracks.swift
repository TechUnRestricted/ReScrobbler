//
//  getTopTracks.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//


class getTopTracks {
    
    struct jsonStruct: Codable {
        let tracks: Tracks?
    }
    
    // MARK: - Tracks
    struct Tracks: Codable {
        let track: [Track]?
        let attr: Attr?
        
        enum CodingKeys: String, CodingKey {
            case track
            case attr = "@attr"
        }
    }
    
    // MARK: - Attr
    struct Attr: Codable {
        let page, perPage, totalPages, total: String?
    }
    
    // MARK: - Track
    struct Track: Codable {
        let name, duration, playcount, listeners: String?
        let mbid: String?
        let url: String?
        let streamable: Streamable?
        let artist: Artist?
        let image: [Image]?
    }
    
    // MARK: - Artist
    struct Artist: Codable {
        let name, mbid: String?
        let url: String?
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
        case small = "small"
    }
    
    // MARK: - Streamable
    struct Streamable: Codable {
        let text, fulltrack: String?
        
        enum CodingKeys: String, CodingKey {
            case text = "#text"
            case fulltrack
        }
    }
    
}
