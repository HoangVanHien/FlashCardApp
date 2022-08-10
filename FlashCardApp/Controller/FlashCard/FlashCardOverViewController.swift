//
//  FlashCardViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class FlashCardOverViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewWordButton: UIImageView!
    var cellHeight: [CGFloat] = []
    var flashCard: FlashCardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCellByNib(FlashCardOverViewTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        addNewWordButton.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                          action: #selector(addNewWordAction)))
    }
    @IBAction func startAction(_ sender: UIButton) {
        let vc = FlashCardViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    @objc func addNewWordAction(){
        let addNewWord = AddNewWordViewController()
        addNewWord.delegate = self
        addNewWord.flashCard = flashCard
        presentView(addNewWord)
    }
}

extension FlashCardOverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashCard?.words?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(FlashCardOverViewTableViewCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        cell.setUpFromWord(word: flashCard?.words?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FlashCardOverViewController{
    func presentView(_ viewController: BaseViewController) {
        let viewController = viewController
        let navi = BaseNavigationController(rootViewController: viewController)
        navi.modalPresentationStyle = .overFullScreen
        navi.modalTransitionStyle = .crossDissolve
        present(navi, animated: true)
    }
}

extension FlashCardOverViewController: AddNewWordDelegate{
    func didAddNewWord() {
        tableView.reloadData()
    }
}
