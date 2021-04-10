//
//  Fake.swift
//  Test
//
//  Created by Prince Alvin Yusuf on 09/04/21.
//

import Foundation

import Foundation

// MARK: - FakeElement
struct FakeElement: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Fake = [FakeElement]
