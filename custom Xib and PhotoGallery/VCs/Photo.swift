//
//  Photo.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//

import Foundation
//MARK: Coder / decoder
class Photo: Codable {
    var name: String
    var message: String
    var isLiked: Bool = false
    init(name:String, message: String) {
        self.name = name
        self.message = message
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, message, isLiked
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.message = try container.decode(String.self, forKey: .message)
        self.isLiked = try container.decode(Bool.self, forKey: .isLiked)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.message, forKey: .message)
        try container.encode(self.isLiked, forKey: .isLiked)
    }
}

