// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photo = try? newJSONDecoder().decode(Photo.self, from: jsonData)

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
    let photoDescription: Description?
    let dateupload, lastupdate, ownername, iconserver: String?
    let iconfarm: Int?
    let originalsecret, originalformat: String?

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
        case photoDescription = "description"
        case dateupload, lastupdate, ownername, iconserver, iconfarm, originalsecret, originalformat
    }
}

// MARK: - Description
struct Description: Codable {
    let content: String?

    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}

