//
//  Caching.swift
//  ImageDownloader
//
//  Created by Ahmed Henawey on 18/02/2020.
//  Copyright © 2020 Ahmed Henawey. All rights reserved.
//

import UIKit

protocol Cache {
    associatedtype T
    func set(key: String, type: T)
    func get(key: String) -> T?
}

struct AnyCache<Type>: Cache {
    typealias T = Type

    private var _set: (_ key: String, _ type: Type) -> Void
    private var _get: (_ key: String) -> Type?

    init<Caching: Cache>(cache: Caching) where Caching.T == Type {
        self._set = cache.set
        self._get = cache.get
    }

    func set(key: String, type: Type) {
        _set(key, type)
    }

    func get(key: String) -> Type? {
        return _get(key)
    }
}

final class MemoryCache: Cache {
    typealias T = UIImage

    private var cache = [String: T]()

    func set(key: String, type: UIImage) {
        cache[key] = type
    }

    func get(key: String) -> UIImage? {
        return cache[key]
    }
}
