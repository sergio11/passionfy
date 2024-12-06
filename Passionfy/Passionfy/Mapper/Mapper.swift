//
//  Mapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 6/12/24.
//

import Foundation

protocol Mapper {
    associatedtype Input
    associatedtype Output
    
    func map(_ input: Input) -> Output
}
