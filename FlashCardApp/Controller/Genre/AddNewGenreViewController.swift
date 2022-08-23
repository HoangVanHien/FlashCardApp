//
//  AddNewGenreViewController.swift
//  FlashCardApp
//
//  Created by mk1 on 22/07/2022.
//  Copyright © 2022 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol AddNewGenreDelegate: class {
    func didAddNewGenre()
}

class AddNewGenreViewController: BaseViewController{

    @IBOutlet weak var functionView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    weak var delegate: AddNewGenreDelegate?
    
    
    
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
        
        
        let newGenre = GenreModel(
            cloudId: nil, localId: LocalAppModelData.genres.count, title: name, owner: Auth.auth().currentUser?.uid, flashCards: nil)
        
        LocalAppModelData.genres.append(newGenre)
        LocalAppModelData.saveLocalData()
        
        print(LocalAppModelData.genres[LocalAppModelData.genres.count-1].title)
        
        delegate?.didAddNewGenre()
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddNewGenreViewController{
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

extension AddNewGenreViewController: UITextFieldDelegate {
    
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
