//
//  MockData.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 27/11/24.
//

import Foundation

struct MockData {
    
    static let users: [User] = [
        .init(id: NSUUID().uuidString, fullname: "Megan Fox", age: 37, profileImageURLs: ["example"]),
        .init(id: NSUUID().uuidString, fullname: "David Beckham", age: 37, profileImageURLs: ["example"]),
        .init(id: NSUUID().uuidString, fullname: "Conor Mcregor", age: 37, profileImageURLs: ["example"])
    ]
        
    
}
