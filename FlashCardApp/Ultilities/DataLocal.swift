//
//  DataLocal.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/12/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class DataLocal: NSObject {
    class func saveObject(_ value: Any?, forKey defaultName: String) {
        UserDefaults.standard.set(value, forKey: defaultName)
    }
        
    class func getObject(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func removeObject(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    class func saveData(forKey key: String, _ object: Any) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        DataLocal.saveObject(data, forKey: key)
    }
    
    class func getData(forKey key: String) -> Any? {
        guard let data = DataLocal.getObject(key ) as? Data else {
            return nil
        }
        guard let unarchiveData = NSKeyedUnarchiver.unarchiveObject(with: data) else {
            return nil
        }
        return unarchiveData
    }
}
