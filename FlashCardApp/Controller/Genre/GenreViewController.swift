//
//  GenreViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import ALProgressRing
import SwipeCellKit

class GenreViewController: BaseViewController {

    @IBOutlet weak var addNewFlashCardButton: UIImageView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var flashCardCountLabel: UILabel!
    @IBOutlet weak var totalWordsLabel: UILabel!
    @IBOutlet weak var learnedWordsLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var progressRing = ALProgressRing()
    
    var genre: GenreModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleHeader(title: genre?.title ?? "Genre Title")
        setupProgressView()
        setUpFromGenre()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCellByNib(BigFlashcardCollectionViewCell.self)
        
        addNewFlashCardButton.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                          action: #selector(addNewFlashCardAction)))
        
        
    }
    
    func setupProgressView() {
        progressView.addSubview(progressRing)
        progressRing.translatesAutoresizingMaskIntoConstraints = false
        progressRing.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        progressRing.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        progressRing.widthAnchor.constraint(equalToConstant: progressView.frame.width).isActive = true
        progressRing.heightAnchor.constraint(equalToConstant: progressView.frame.height).isActive = true
        
        progressRing.startColor = UIColor.thirdColor ?? .systemPink
        progressRing.endColor = UIColor.primaryColor ?? .systemRed
        progressRing.ringWidth = 10
        progressRing.grooveWidth = 8
    }
    
    func setUpFromGenre(){
        flashCardCountLabel.text = "Flashcards: \(genre?.flashCards?.count ?? 0)"
        let total = genre?.totalWordCount() ?? 0
        guard total > 0 else{
            progressRing.setProgress(0, animated: true)
            progressLabel.text = "0%"
            totalWordsLabel.text = "Total words: 0"
            learnedWordsLabel.text = "Learned words: 0"
            return
        }
        totalWordsLabel.text = "Total words: \(total)"
        let learned = genre?.learnedWordCount() ?? 0
        learnedWordsLabel.text = "Learned words: \(learned)"
        let progress = Float(learned) / Float(total)
        progressRing.setProgress(progress, animated: true)
        progressLabel.text = "\(Float(learned) / Float(total) * 100)%"
    }
    
    @objc func addNewFlashCardAction(){
        let addNewFlashCard = AddNewFlashCardViewController()
        addNewFlashCard.delegate = self
        addNewFlashCard.genre = genre
        presentView(addNewFlashCard)
    }
}

extension GenreViewController: UICollectionViewDelegateFlowLayout,
                               UICollectionViewDelegate,
                               UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return genre?.flashCards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let reusableCell = collectionView.dequeueCell(BigFlashcardCollectionViewCell.self, forIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        reusableCell.delegate = self
        reusableCell.setUpFromFlashCard(flashCard: genre?.flashCards?[indexPath.section])
        return reusableCell
    }
    
    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = DeviceInfo.width
        let height = width * 150/375
        
        let size = CGSize(width: width, height: height)
        return size
    }
}

extension GenreViewController: SwipeCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
}

extension GenreViewController: AddNewFlashCardDelegate{
    func didAddNewFlashCard() {
        collectionView.reloadData()
        setUpFromGenre()
    }
}

extension GenreViewController{
    func presentView(_ viewController: BaseViewController) {
        let viewController = viewController
        let navi = BaseNavigationController(rootViewController: viewController)
        navi.modalPresentationStyle = .overFullScreen
        navi.modalTransitionStyle = .crossDissolve
        present(navi, animated: true)
    }
}
