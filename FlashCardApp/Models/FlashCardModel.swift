//
//  FlashCardModel.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class FlashCardModel: NSObject, NSCoding, Decodable {
    var title: String
    var totalWords: Int?
    var learnedWords: Int?
    var words = [String: WordModel]()

    init(
         title: String,
         totalWords: Int?,
         learnedWords: Int?,
         words : [String: WordModel]?
    ) {
        self.title = title
        self.totalWords = totalWords
        self.learnedWords = learnedWords
        if let cfWords = words{
            for word in cfWords {
                self.words[word.key] = word.value
            }
        }
    }

    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as? String
        let totalWords = aDecoder.decodeInteger(forKey: "totalWords")
        let learnedWords = aDecoder.decodeInteger(forKey: "learnedWords")
        let words = aDecoder.decodeObject(forKey: "words") as? [String: WordModel]
        self.init(
                  title: title ?? "",
                  totalWords: totalWords,
                  learnedWords: learnedWords,
                  words: words
        )
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(totalWords, forKey: "totalWords")
        aCoder.encode(learnedWords, forKey: "learnedWords")
        aCoder.encode(words, forKey: "words")
    }

    enum CodingKeys: String, CodingKey {
        case title
        case totalWords
        case learnedWords
        case words
    }
}
