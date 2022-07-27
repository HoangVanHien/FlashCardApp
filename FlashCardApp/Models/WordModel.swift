//
//  WordModel.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 07/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class WordModel: NSObject, NSCoding, Decodable {
    var word: String
    var meaning: String?
    var learned: Int?

    init(
         word: String,
         meaning: String?,
         learned: Int?) {
        self.word = word
        self.meaning = meaning
        self.learned = learned
    }

    required convenience init(coder aDecoder: NSCoder) {
        let word = aDecoder.decodeObject(forKey: "word") as? String
        let meaning = aDecoder.decodeObject(forKey: "meaning") as? String
        let learned = aDecoder.decodeObject(forKey: "learned") as? Int
        self.init(
                  word: word ?? "",
                  meaning: meaning,
                  learned: learned)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(word, forKey: "word")
        aCoder.encode(meaning, forKey: "meaning")
        aCoder.encode(learned, forKey: "learned")
    }

    enum CodingKeys: String, CodingKey {
        case word
        case meaning
        case learned
    }
}
