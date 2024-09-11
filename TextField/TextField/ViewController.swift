//
//  ViewController.swift
//  TextField
//
//  Created by hyejeong im on 9/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField()
        
        textfield.delegate = self
        textfield.becomeFirstResponder()
    }
    
    func configureTextField() {
        textfield.placeholder = "E-mail Address"
        textfield.borderStyle = .roundedRect
        textfield.clearButtonMode = .always
        textfield.keyboardType = .emailAddress
        textfield.returnKeyType = .done
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        textfield.placeholder = "E-mail Address"
        textField.clearsOnBeginEditing = true
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 백스페이스 허용
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        
        // 문자만 허용
        if string.allSatisfy({$0.isNumber}) {
            return false
        }
        
        // 10글자 이하 허용
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count
        return newLength <= 10
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textfield.resignFirstResponder()
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        
        if text.isEmpty {
            textField.placeholder = "Required"
            return false
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
