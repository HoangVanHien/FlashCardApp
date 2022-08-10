//
//  FlashCardCollectionViewCell.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 28/02/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import ALProgressRing

class FlashCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var flashCardTitle: UILabel!
    @IBOutlet weak var wordCount: UILabel!
    
    var flashCard: FlashCardModel?
    
    private lazy var progressRing = ALProgressRing()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        layer.cornerRadius = 15
        progressView.addSubview(progressRing)
        progressRing.translatesAutoresizingMaskIntoConstraints = false
        progressRing.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        progressRing.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        progressRing.widthAnchor.constraint(equalToConstant: 40).isActive = true
        progressRing.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        progressRing.startColor = UIColor.thirdColor ?? .systemPink
        progressRing.endColor = UIColor.primaryColor ?? .systemRed
        progressRing.ringWidth = 5
        progressRing.grooveWidth = 4
    }
    
    func setUpFromFlashCard(flashCard newFC: FlashCardModel?){
        flashCard = newFC
        flashCardTitle.text = flashCard?.title
        let total = flashCard?.words?.count ?? 0
        guard total > 0 else{
            progressRing.setProgress(0, animated: true)
            progressLabel.text = "0"
            wordCount.text = "0"
            return
        }
        wordCount.text = "\(total)"
        let progress = Float(flashCard!.learnedWords ?? 0) / Float(total)
        progressRing.setProgress(progress, animated: true)
        progressLabel.text = "\(progress * 100)%"
    }
}
