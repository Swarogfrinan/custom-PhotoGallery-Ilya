//
//  CreateViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//

import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.textFieldShouldEndEditing(_:)))
//
//        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        if rulesToDo(){            UserDefaults.standard.setValue(firstTextField, forKey: Keys.pass.rawValue)
            dismiss(animated: true, completion: nil)
    }
    }
    
    private func rulesToDo() -> Bool{
        var error = false
        if firstTextField.text == "" {
            UIView.animate(withDuration: 0.3){
                self.firstTextField.backgroundColor = .red
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.firstTextField.backgroundColor = .white
                } completion: { _ in
                    self.showAlert(title:"Error", message: "Empty password", defaultAction: nil)
                }
            }
            
            error = true
            
            }
        
        if secondTextField.text == "" {
            UIView.animate(withDuration: 0.3){
                self.secondTextField.backgroundColor = .red
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.secondTextField.backgroundColor = .white
                } completion: { _ in
                    self.showAlert(title:"Error", message: "Empty password", defaultAction: nil)
        }
    }
    error = true
        }
        
            if error {return false}
            if firstTextField.text != secondTextField.text, firstTextField.text != ""{
                self.showAlert(title:"Error!", message: "password dosnt match", defaultAction: nil)
                error = true
            }
            if error {
                
                return false
            } else {
                
                return true
            }
}
    

}

