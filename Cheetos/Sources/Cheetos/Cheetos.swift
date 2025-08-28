//
//  Cheetos.swift
//  Cheetos
//
//  Created by 김민우 on 8/28/25.
//
import Foundation
import Values


// MARK: Object
@MainActor @Observable
public final class Cheetos: Sendable {
    // MARK: core
    public init() {
        CheetosManager.register(self)
    }
    internal func delete() {
        CheetosManager.unregister(self.id)
    }
    
    
    // MARK: state
    public nonisolated let id = ID()
    
    
    
    
    // MARK: action
    public func fetchTodayForture() async {
        // capture
        
        
        // mutate
    }
    
    
    // MARK: value
    @MainActor
    public struct ID: Sendable, Hashable {
        public let rawValue = UUID()
        nonisolated init() { }
        
        public var isExist: Bool {
            CheetosManager.container[self] != nil
        }
        public var ref: Cheetos? {
            CheetosManager.container[self]
        }
    }
}


// MARK: ObjectManager
@MainActor @Observable
fileprivate final class CheetosManager: Sendable {
    // MARK: core
    static var container: [Cheetos.ID: Cheetos] = [:]
    static func register(_ object: Cheetos) {
        self.container[object.id] = object
    }
    static func unregister(_ id: Cheetos.ID) {
        self.container[id] = nil
    }
}
