//
//  Cheetos.swift
//  Cheetos
//
//  Created by 김민우 on 8/28/25.
//
import Foundation


// MARK: Object
@MainActor @Observable
public final class Cheetos: Sendable {
    // MARK: core
    public init() {
        
    }
    
    
    // MARK: state
    public nonisolated let id = ID()
    
    
    // MARK: action
    
    
    // MARK: value
    @MainActor
    public struct ID: Sendable, Hashable {
        public let rawValue = UUID()
        nonisolated init() { }
        
        public var isExist: Bool { fatalError() }
        public var ref: Cheetos? { fatalError() }
    }
}


// MARK: ObjectManager
@MainActor @Observable
fileprivate final class CheetosManager: Sendable {
    // MARK: core
    static var container: [Cheetos.ID: Cheetos] = [:]
}
