//
//  jsonTrackGetInfo.swift
//  ReScrobbler
//
//  Created by Mac on 27.09.2021.
//

class jsonTrackGetInfo{
    
    // MARK: - Welcome
    struct jsonStruct: Codable {
        let track: Track?
    }

    // MARK: - Track
    struct Track: Codable {
        let name: String?
        let url: String?
        let duration: String?
        let streamable: Streamable?
        let listeners, playcount: String?
        let artist: Artist?
        let album: Album?
        let toptags: Toptags?
        let wiki: Wiki?
    }

    // MARK: - Album
    struct Album: Codable {
        let artist, title: String?
        let url: String?
        let image: [Image]?
    }

    // MARK: - Image
    struct Image: Codable {
        let text: String?
        let size: String?

        enum CodingKeys: String, CodingKey {
            case text = "#text"
            case size
        }
    }

    // MARK: - Artist
    struct Artist: Codable {
        let name, mbid: String?
        let url: String?
    }

    // MARK: - Streamable
    struct Streamable: Codable {
        let text, fulltrack: String?

        enum CodingKeys: String, CodingKey {
            case text = "#text"
            case fulltrack
        }
    }

    // MARK: - Toptags
    struct Toptags: Codable {
        let tag: [Tag]?
    }

    // MARK: - Tag
    struct Tag: Codable {
        let name: String?
        let url: String?
    }

    // MARK: - Wiki
    struct Wiki: Codable {
        let published, summary, content: String?
    }

    
}
