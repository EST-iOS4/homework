//
//  Forture.swift
//  Cheetos
//
//  Created by 김민우 on 8/28/25.
//
import Foundation
import Values


// MARK: Object
@MainActor @Observable
public final class Forture: MessageInterface {
    // MARK: core
    internal init(owner: Cheetos.ID, content: String) {
        self.owner = owner
        self.content = content
        
        FortuneManager.register(self)
    }
    internal func delete() {
        FortuneManager.unregister(self.id)
    }
    
    
    // MARK: state
    public nonisolated let id = ID()
    internal nonisolated let owner: Cheetos.ID
    public nonisolated let isMyMessage: Bool = false
    
    public var content: String
    
    
    // MARK: action
    
    
    
    // MARK: value
    @MainActor
    public struct ID: MessageIDRepresentable {
        public let rawValue = UUID()
        nonisolated init() { }
        
        public var isExist: Bool {
            FortuneManager.container[self] != nil
        }
        public var ref: Forture? {
            FortuneManager.container[self]
        }
    }
}



// MARK: ObjectManager
@MainActor @Observable
fileprivate final class FortuneManager: Sendable {
    // MARK: core
    static var container: [Forture.ID:Forture] = [:]
    static func register(_ object:Forture) {
        container[object.id] = object
    }
    static func unregister(_ id:Forture.ID) {
        container[id] = nil
    }
}
