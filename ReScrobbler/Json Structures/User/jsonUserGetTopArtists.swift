//
//  jsonUserGetTopArtists.swift
//  ReScrobbler
//
//  Created on 16.09.2021.
//

class jsonUserGetTopArtists{
    
    // MARK: - Welcome
    struct jsonStruct: Codable {
        let topartists: Topartists?
    }

    // MARK: - Topartists
    struct Topartists: Codable {
        let artist: [Artist]?
        let attr: TopartistsAttr?

        enum CodingKeys: String, CodingKey {
            case artist
            case attr = "@attr"
        }
    }

    // MARK: - Artist
    struct Artist: Codable {
        let attr: ArtistAttr?
        let mbid: String?
        let url: String?
        let playcount: String?
        let image: [Image]?
        let name, streamable: String?

        enum CodingKeys: String, CodingKey {
            case attr = "@attr"
            case mbid, url, playcount, image, name, streamable
        }
    }

    // MARK: - ArtistAttr
    struct ArtistAttr: Codable {
        let rank: String?
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

    // MARK: - TopartistsAttr
    struct TopartistsAttr: Codable {
        let page, total, user, perPage: String?
        let totalPages: String?
    }
}
