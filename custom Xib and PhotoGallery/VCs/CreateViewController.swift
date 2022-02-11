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
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.textFieldShouldEndEditing(_:)))
//
//        self.view.addGestureRecognizer(tapGesture)
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
                self.firstTextField.frame.origin.x += 5
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.firstTextField.frame.origin.x -= 5
                    self.firstTextField.backgroundColor = .white
                } completion: { _ in
                    self.showAlert(title:"Error", message: "Empty password", defaultAction: nil)
                }
            }
            
            error = true
            
            }
        //MARK: Проверка secondTextField
        if secondTextField.text == "" {
            UIView.animate(withDuration: 0.3){
                self.secondTextField.backgroundColor = .red
                self.secondTextField.frame.origin.x += 5
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.secondTextField.backgroundColor = .white
                    self.secondTextField.frame.origin.x -= 5
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
        if let count = firstTextField.text?.count, count <= 3{
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
extension CreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
