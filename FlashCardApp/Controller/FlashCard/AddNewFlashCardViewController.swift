//
//  AddNewFlashCardViewController.swift
//  FlashCardApp
//
//  Created by mk1 on 05/08/2022.
//  Copyright © 2022 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

protocol AddNewFlashCardDelegate: class {
    func didAddNewFlashCard()
}

class AddNewFlashCardViewController: BaseViewController {

    @IBOutlet weak var functionView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    weak var delegate: AddNewFlashCardDelegate?
    var genre: GenreModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGesture()
        setupTextField()
    }
    
    @IBAction func onOkButtonTouch(_ sender: UIButton) {
        guard checkEdited() else{
            return
        }
        guard let name = nameTextField.text else{
            return
        }
                                                                                                                                                                                          
        
        let flashCard = FlashCardModel(id: genre?.flashCards?.count ?? 0, title: name, learnedWords: 0, words: nil)
        
        if genre?.flashCards != nil{
            genre?.flashCards?.append(flashCard)
        }
        else{
            genre?.flashCards = [flashCard]
        }
        LocalAppModelData.updateLocalData()
        
        delegate?.didAddNewFlashCard()
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddNewFlashCardViewController{
    func setGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissView() {
        if checkEdited() {
            view.endEditing(true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view?.isDescendant(of: functionView) == true {
            return false
        }
        return true
    }
}

extension AddNewFlashCardViewController: UITextFieldDelegate {
    
    func setupTextField() {
        nameTextField.delegate = self
    }
    
    func checkEdited() -> Bool {
        if (nameTextField.text != "" && nameTextField.isEditing) {
            return true
        }
        nameTextField.placeholder = Localizable.blankInputName
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
