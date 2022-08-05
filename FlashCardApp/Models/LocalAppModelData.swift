//
//  LocalAppModelData.swift
//  FlashCardApp
//
//  Created by mk1 on 05/08/2022.
//  Copyright © 2022 Nguyễn Đức Tân. All rights reserved.
//

import Foundation

class LocalAppModelData{
    static let keyString = "localGenres"
    static var localId = 0
    static var genres: [GenreModel] = []
    
    static var currentGenre: GenreModel?
    static var currentFlashCard: FlashCardModel?
    static var currentWord: WordModel?
    
    class func updateLocalData() {
        DataLocal.saveData(forKey: keyString, genres)
    }
    
    class func getLocalData(){
        if let genresTmp = DataLocal.getData(forKey: keyString) as? [GenreModel]{
            genres = genresTmp
        }
    }
}
