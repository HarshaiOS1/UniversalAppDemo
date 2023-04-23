//
//  FootballNewsModel.swift
//  UniversalAppDemo
//
//  Created by Harsha on 21/04/2023.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let empty = try? JSONDecoder().decode(Empty.self, from: jsonData)

import Foundation

// MARK: - FootballNewsModel
struct FootballNewsModel: Codable {
    let category: String?
    let data: [Datum?]
    let success: Bool?
}

// MARK: - Datum
struct Datum: Codable {
    let author, content, date, id: String?
    let imageURL: String?
    let readMoreURL: String?
    let time, title: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case author, content, date, id
        case imageURL = "imageUrl"
        case readMoreURL = "readMoreUrl"
        case time, title, url
    }
}
