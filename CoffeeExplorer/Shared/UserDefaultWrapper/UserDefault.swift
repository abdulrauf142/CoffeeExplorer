//
//  UserDefault.swift
//  CoffeeExplorer
//
//  Created by ar on 17/11/2021.
//

import Foundation

protocol Storage {
    func value(forKey key: String) -> Any?
    func setValue(_ value: Any?, forKey key: String)
}

extension UserDefaults: Storage { }

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var storage: Storage = UserDefaults.standard

    var wrappedValue: Value {
        get { storage.value(forKey: key) as? Value ?? defaultValue }
        set { storage.setValue(newValue, forKey: key) }
    }
}
