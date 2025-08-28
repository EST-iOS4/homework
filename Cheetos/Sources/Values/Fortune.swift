//
//  Fortune.swift
//  Cheetos
//
//  Created by 김민우 on 8/28/25.
//
import Foundation


// MARK: Value
public struct Fortune: Codable {
    // MARK: core
    public let message: String
    public let author: String?
    public let authorProfile: String?
    
    
    // MARK: core
    public var content: String {
        self.message
    }
    public var isMyMessage: Bool {
        false
    }
}
