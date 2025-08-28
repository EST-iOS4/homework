//
//  MyText.swift
//  Cheetos
//
//  Created by 김민우 on 8/28/25.
//
import Foundation


// MARK: Value
public struct MyText {
    // MARK: core
    public let text: String
    public let timestamp: Date = .now
    
    
    // MARK: operator
    public var content: String {
        self.text
    }
    public var isMyMessage: Bool {
        false
    }
}
