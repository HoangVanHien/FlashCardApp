//
//  GenreModel.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class GenreModel: NSObject, NSCoding, Decodable {
    var title: String
    var owner: String?
    var flashCards = [String: FlashCardModel]()

    init(
         title: String,
         owner: String?,
         flashCards: [String: FlashCardModel]?) {
             self.title = title
             self.owner = owner
             if let cfFC = flashCards{
                 for fC in cfFC {
                     self.flashCards[fC.key] = fC.value
                 }
             }
    }

    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as? String
        let owner = aDecoder.decodeObject(forKey: "owner") as? String
        let flashCards = aDecoder.decodeObject(forKey: "flashCards") as? [String: FlashCardModel]
        self.init(
                  title: title ?? "",
                  owner: owner,
                  flashCards: flashCards)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(owner, forKey: "owner")
        aCoder.encode(flashCards, forKey: "flashCards")
    }

    enum CodingKeys: String, CodingKey {
        case title
        case owner
        case flashCards
    }
    
    func genreID()->String{
        return "\(title)\(String(describing: UnicodeScalar(219)))\(owner ?? "")"
    }
}
