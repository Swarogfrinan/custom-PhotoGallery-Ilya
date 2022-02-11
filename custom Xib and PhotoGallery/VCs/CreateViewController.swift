//
//  CreateViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//
//MARK: Первейшая регистрация
import UIKit
import AudioToolbox
class CreateViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    //MARK: lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
    //MARK: Func
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        if rulesToDo(){            UserDefaults.standard.setValue(firstTextField.text, forKey: Keys.pass.rawValue)
            dismiss(animated: true, completion: nil)
    }
    }
    
    
    @IBAction func showPassButtonFirst(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if !sender.isSelected == true {
        firstTextField.isSecureTextEntry = true
    }
     else {
        firstTextField.isSecureTextEntry = false
    }
        }
    
    @IBAction func showPassButtonSecond(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if !sender.isSelected == true {
        secondTextField.isSecureTextEntry = true
    }
     else {
        secondTextField.isSecureTextEntry = false
    }
        }
    
    
    
    //MARK: Func что-то здесь сломано
    private func rulesToDo() -> Bool{
        var error = false
        if firstTextField.text == "" {
            UIView.animate(withDuration: 0.3){
                self.firstTextField.backgroundColor = .red
                self.firstTextField.frame.origin.x += 3
                self.firstTextField.frame.origin.y -= 3
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.firstTextField.frame.origin.y += 3
                    self.firstTextField.frame.origin.x -= 3
                    self.firstTextField.backgroundColor = .white
                } completion: { _ in
                    self.showAlert(title:"Error", message: "Empty password", defaultAction: nil)
                }
            }
            
            error = true
            
            }
        if error == true {
                UIView.animate(withDuration: 0.3){
                    self.secondTextField.backgroundColor = .red
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    self.secondTextField.frame.origin.x += 3
                    self.secondTextField.frame.origin.y -= 3
                    
                } completion: { _ in
                    UIView.animate(withDuration: 0.3) {
                        self.secondTextField.frame.origin.x -= 3
                        self.secondTextField.frame.origin.y += 3
                        self.secondTextField.backgroundColor = .white
        }
                }
        }
        
        //MARK: Проверка secondTextField
        if secondTextField.text == "" {
            UIView.animate(withDuration: 0.3){
                self.secondTextField.backgroundColor = .red
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                self.secondTextField.frame.origin.x += 3
                self.secondTextField.frame.origin.y -= 3
                
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.secondTextField.frame.origin.x -= 3
                    self.secondTextField.frame.origin.y += 3
                    self.secondTextField.backgroundColor = .white
                    
                } completion: { _ in
                    self.showAlert(title:"Error", message: "Empty password", defaultAction: nil)
        }
    }
    error = true
        }
            if error {return false}
            if firstTextField.text != secondTextField.text, firstTextField.text != ""{
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                self.showAlert(title:"Error!", message: "password dosnt match", defaultAction: nil)
                error = true
            }
        if let count = firstTextField.text?.count, count <= 3{
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            showAlert(title: "Eror!", message: "Your password need 4 symbols and more", defaultAction: nil)
            error = true
        }
            if error {
                return false
                
            } else {
            return true
            }
    }
}

//extension CreateViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//     hidekeyboard()
//        return true
//    }
//
//    func hidekeyboard() {
//        self.firstTextField.resignFirstResponder()
////        self.secondTextField.resignFirstResponder()
//}
//
//}

