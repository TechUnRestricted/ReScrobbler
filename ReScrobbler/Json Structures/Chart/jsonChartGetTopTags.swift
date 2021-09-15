//
//  getTopTags.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

class jsonChartGetTopTags {
    struct jsonStruct: Codable {
        let tags: Tags?
    }

    // MARK: - Tags
    struct Tags: Codable {
        let tag: [Tag]?
        let attr: Attr?

        enum CodingKeys: String, CodingKey {
            case tag
            case attr = "@attr"
        }
    }

    // MARK: - Attr
    struct Attr: Codable {
        let page, perPage, totalPages, total: String?
    }

    // MARK: - Tag
    struct Tag: Codable {
        let name: String?
        let url: String?
        let reach, taggings, streamable: String?
        let wiki: Wiki?
    }

    // MARK: - Wiki
    struct Wiki: Codable {
    }

}
