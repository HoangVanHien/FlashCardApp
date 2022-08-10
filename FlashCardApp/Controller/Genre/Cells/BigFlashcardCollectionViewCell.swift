//
//  BigFlashcardCollectionViewCell.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import SwipeCellKit

class BigFlashcardCollectionViewCell: SwipeCollectionViewCell {

    @IBOutlet weak var flashCardNameLabel: UILabel!
    @IBOutlet weak var learnedWordsLabel: UILabel!
    @IBOutlet weak var totalWordLabel: UILabel!
    @IBOutlet weak var upLoadButton: UIView!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var seeDetailButton: UIView!
    
    var flashCard: FlashCardModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upLoadButton.layer.cornerRadius = upLoadButton.frame.height/2
        seeDetailButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(seeDetailAction)))
    }
    
    func setUpFromFlashCard(flashCard newFC: FlashCardModel?){
        flashCard = newFC
        flashCardNameLabel.text = flashCard?.title
        totalWordLabel.text = "\(flashCard?.words?.count ?? 0) words"
        learnedWordsLabel.text = "Learned words: \(flashCard?.learnedWords ?? 0)"
    }
    
    @objc func seeDetailAction() {
        let vc = FlashCardOverViewController()
        vc.flashCard = flashCard
        vc.hidesBottomBarWhenPushed = true
        UIViewController.top()?.push(vc)
    }

}
