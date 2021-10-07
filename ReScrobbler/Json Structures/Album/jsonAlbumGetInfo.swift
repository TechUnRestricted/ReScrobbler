//
//  jsonAlbumGetInfo.swift
//  ReScrobbler
//
//  Created by Mac on 03.10.2021.
//

class jsonAlbumGetInfo{
    // MARK: - Welcome
    struct jsonStruct: Codable {
        let album: Album?
    }

    // MARK: - Album
    struct Album: Codable {
        let listeners, playcount: String?
        let wiki: Wiki?
        let tracks: Tracks?
        let image: [Image]?
        let tags: Tags?
        let url: String?
        let artist, name, mbid: String?
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

    // MARK: - Tags
    struct Tags: Codable {
        let tag: [Tag]?
    }

    // MARK: - Tag
    struct Tag: Codable {
        let name: String?
        let url: String?
    }

    // MARK: - Tracks
    struct Tracks: Codable {
        let track: [Track]?
    }

    // MARK: - Track
    struct Track: Codable {
        let artist: Artist?
        let attr: Attr?
        let duration: Int?
        let url: String?
        let name: String?
        let streamable: Streamable?

        enum CodingKeys: String, CodingKey {
            case artist
            case attr = "@attr"
            case duration, url, name, streamable
        }
    }

    // MARK: - Artist
    struct Artist: Codable {
        let url: String?
        let name, mbid: String?
    }

    // MARK: - Attr
    struct Attr: Codable {
        let rank: Int?
    }

    // MARK: - Streamable
    struct Streamable: Codable {
        let fulltrack, text: String?

        enum CodingKeys: String, CodingKey {
            case fulltrack
            case text = "#text"
        }
    }

    // MARK: - Wiki
    struct Wiki: Codable {
        let published, content, summary: String?
    }

}
