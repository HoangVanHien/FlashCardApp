//
//  GenreModel.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class GenreModel: NSObject, NSCoding, Decodable {
    var cloudId: String?
    var localId: Int
    var title: String
    var owner: String?
    var flashCards: [FlashCardModel]?
    
    init(
        cloudId: String?,
        localId: Int,
        title: String,
        owner: String?,
        flashCards: [FlashCardModel]?) {
            self.cloudId = cloudId
            self.localId = localId
            self.title = title
            self.owner = owner
            self.flashCards = flashCards
    }

    required convenience init(coder aDecoder: NSCoder) {
        let cloudId = aDecoder.decodeObject(forKey: "cloudId") as? String
        let localId = aDecoder.decodeInteger(forKey: "localId")
//        guard let localId = aDecoder.decodeObject(forKey: "localId") as? Int else{
//            print("flash card localId decode fail")
//            self.init(cloudId: nil,localId: -1, title: "", owner: nil, flashCards: nil)
//            return
//        }
        guard let title = aDecoder.decodeObject(forKey: "title") as? String else{
            print("flash card title decode fail")
            self.init(cloudId: nil,localId: -1, title: "", owner: nil, flashCards: nil)
            return
        }
        let owner = aDecoder.decodeObject(forKey: "owner") as? String
        let flashCards = aDecoder.decodeObject(forKey: "flashCards") as? [FlashCardModel]
        self.init(cloudId: cloudId,
                  localId: localId,
                  title: title,
                  owner: owner,
                  flashCards: flashCards)
        print(localId)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(cloudId, forKey: "cloudId")
        aCoder.encode(localId, forKey: "localId")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(owner, forKey: "owner")
        aCoder.encode(flashCards, forKey: "flashCards")
    }

    enum CodingKeys: String, CodingKey {
        case cloudId
        case localId
        case title
        case owner
        case flashCards
    }
    
    func updateCloudID(){
        guard owner != nil else{
            return
        }
        cloudId = "\(title)\(String(describing: UnicodeScalar(219)))\(owner ?? "")"
    }
    
    func totalWordCount()->Int{
        guard flashCards?.count ?? -1 > 0 else{
            return 0
        }
        var total = 0
        for fc in flashCards! {
            total += fc.words?.count ?? 0
        }
        return total
    }
    
    func learnedWordCount()->Int{
        guard flashCards?.count ?? -1 > 0 else{
            return 0
        }
        var total = 0
        for fc in flashCards! {
            total += fc.learnedWords ?? 0
        }
        return total
    }
}
