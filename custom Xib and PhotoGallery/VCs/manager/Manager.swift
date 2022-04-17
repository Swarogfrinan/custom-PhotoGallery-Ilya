//
//  Manager.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 03.04.2022.
//

import Foundation

class Manager {
    static let shared = Manager()
    private init() {}
    var photos : [Photo] {
        get {
            let array = UserDefaults.standard.value([Photo].self, forKey: Keys.photos.rawValue) ?? [Photo]()
            return array
        }
        set {
            print("set")
            UserDefaults.standard.set(encodable: newValue, forKey: Keys.photos.rawValue)
            
}
}
        func updateDefaults(array: [Photo]) {
                UserDefaults.standard.set(encodable: array, forKey: Keys.photos.rawValue)
            }
}
