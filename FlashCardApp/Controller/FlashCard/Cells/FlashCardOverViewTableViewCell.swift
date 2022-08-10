//
//  FlashCardOverViewTableViewCell.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 05/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class FlashCardOverViewTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpFromWord(word:WordModel?){
        wordLabel.text = word?.word
        meaningLabel.text = word?.meaning
    }
}
