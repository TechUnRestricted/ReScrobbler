//
//  jsonUserGetTopTracks.swift
//  ReScrobbler
//
//  Created on 16.09.2021.
//

class jsonUserGetTopTracks{

    // MARK: - Welcome
    struct jsonStruct: Codable {
        let toptracks: Toptracks?
    }

    // MARK: - Toptracks
    struct Toptracks: Codable {
        let attr: ToptracksAttr?
        let track: [Track]?

        enum CodingKeys: String, CodingKey {
            case attr = "@attr"
            case track
        }
    }

    // MARK: - ToptracksAttr
    struct ToptracksAttr: Codable {
        let page, perPage, user, total: String?
        let totalPages: String?
    }

    // MARK: - Track
    struct Track: Codable {
        let attr: TrackAttr?
        let duration, playcount: String?
        let artist: Artist?
        let image: [Image]?
        let streamable: Streamable?
        let mbid, name: String?
        let url: String?

        enum CodingKeys: String, CodingKey {
            case attr = "@attr"
            case duration, playcount, artist, image, streamable, mbid, name, url
        }
    }

    // MARK: - Artist
    struct Artist: Codable {
        let url: String?
        let name, mbid: String?
    }

    // MARK: - TrackAttr
    struct TrackAttr: Codable {
        let rank: String?
    }

    // MARK: - Image
    struct Image: Codable {
        let size: Size?
        let text: String?

        enum CodingKeys: String, CodingKey {
            case size
            case text = "#text"
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
        let fulltrack, text: String?

        enum CodingKeys: String, CodingKey {
            case fulltrack
            case text = "#text"
        }
    }

}
