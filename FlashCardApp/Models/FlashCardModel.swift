//
//  FlashCardModel.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class FlashCardModel: NSObject, NSCoding, Decodable {
    var id: Int
    var title: String
    var learnedWords: Int
    var words : [WordModel]?

    init(
        id: Int,
        title: String,
        learnedWords: Int?,
        words : [WordModel]?
    ) {
        self.id = id
        self.title = title
        self.learnedWords = learnedWords ?? 0
        self.words = words
    }

    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        guard let title = aDecoder.decodeObject(forKey: "title") as? String else{
            print("flash card title decode fail")
            self.init(id: -1, title: "", learnedWords: nil, words: nil)
            return
        }
        let learnedWords = aDecoder.decodeInteger(forKey: "learnedWords")
        let words = aDecoder.decodeObject(forKey: "words") as? [WordModel]
        self.init(
            id: id,
            title: title,
            learnedWords: learnedWords,
            words: words
        )
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(learnedWords, forKey: "learnedWords")
        aCoder.encode(words, forKey: "words")
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case learnedWords
        case words
    }
}
