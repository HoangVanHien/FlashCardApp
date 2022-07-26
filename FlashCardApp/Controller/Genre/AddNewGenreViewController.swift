//
//  AddNewGenreViewController.swift
//  FlashCardApp
//
//  Created by mk1 on 22/07/2022.
//  Copyright © 2022 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

protocol AddNewGenreDelegate: class {
    func didAddNewGenre(genreName: String)
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
        delegate?.didAddNewGenre(genreName: name)
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
        var check = true
        if nameTextField.text == "" {
            nameTextField.placeholder = Localizable.blankInputName
            check = false
        }
        return check
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
