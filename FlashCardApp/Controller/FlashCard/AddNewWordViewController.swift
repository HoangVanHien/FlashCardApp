//
//  AddNewWordViewController.swift
//  FlashCardApp
//
//  Created by mk1 on 10/08/2022.
//  Copyright © 2022 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

protocol AddNewWordDelegate: class {
    func didAddNewWord()
}

class AddNewWordViewController: BaseViewController, UITextViewDelegate {

    @IBOutlet weak var functionView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var meaningTextView: UITextView!
    
    weak var delegate: AddNewWordDelegate?
    var flashCard: FlashCardModel?
    
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
        
        guard let meaning = meaningTextView.text else{
            return
        }
        
        let word = WordModel(id: flashCard?.words?.count ?? 0, word: name, meaning: meaning, learned: 0)
        
        if flashCard?.words != nil{
            flashCard?.words?.append(word)
        }
        else{
            flashCard?.words = [word]
        }
        LocalAppModelData.updateLocalData()
        
        delegate?.didAddNewWord()
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddNewWordViewController{
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

extension AddNewWordViewController: UITextFieldDelegate {
    
    func setupTextField() {
        nameTextField.delegate = self
        meaningTextView.delegate = self
    }
    
    func checkEdited() -> Bool {
        if (nameTextField.text != "" && nameTextField.isEditing) {
            return true
        }
        if (meaningTextView.text != "" && meaningTextView.isFirstResponder) {
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
