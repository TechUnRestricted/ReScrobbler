//
//  UserGetTopAlbums.swift
//  ReScrobbler
//
//  Created on 08.09.2021.
//


class userGetTopAlbums{

    // MARK: - Welcome
    struct jsonStruct: Codable {
        let topalbums: Topalbums?
    }

    // MARK: - Topalbums
    struct Topalbums: Codable {
        let album: [Album]?
        let attr: TopalbumsAttr?

        enum CodingKeys: String, CodingKey {
            case album
            case attr = "@attr"
        }
    }

    // MARK: - Album
    struct Album: Codable {
        let artist: Artist?
        let attr: AlbumAttr?
        let image: [Image]?
        let playcount: String?
        let url: String?
        let name, mbid: String?

        enum CodingKeys: String, CodingKey {
            case artist
            case attr = "@attr"
            case image, playcount, url, name, mbid
        }
    }

    // MARK: - Artist
    struct Artist: Codable {
        let url: String?
        let name, mbid: String?
    }

    // MARK: - AlbumAttr
    struct AlbumAttr: Codable {
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

    // MARK: - TopalbumsAttr
    struct TopalbumsAttr: Codable {
        let page, perPage, user, total: String?
        let totalPages: String?
    }
}
