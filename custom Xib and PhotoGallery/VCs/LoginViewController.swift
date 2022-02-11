//
//  LoginViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var showPassButton: UIButton!
    
    
    
    var new = false {
        didSet {
            if new {
                 self.showCreateNewVc()
            }
        }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.isSecureTextEntry = true
        if UserDefaults.standard.value(forKey: Keys.pass.rawValue) == nil{
            new = true
        }
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.textFieldShouldEndEditing(_:)))
//        self.view.addGestureRecognizer(tapGesture)
//        
    }
    
    @IBAction func showPassButtonPressed(_ sender: UIButton) {
//        textField.isSecureTextEntry = !textField.isSecureTextEntry
        sender.isSelected = !sender.isSelected
        if !sender.isSelected == true {
        textField.isSecureTextEntry = true
    }
     else {
        textField.isSecureTextEntry = false
    }
        }
    
    @IBAction func loginButtonPressed(_sender: UIButton) {
        if checkPass() {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ManagerViewController") as? ManagerViewController else {return}
            self.navigationController?.pushViewController(controller, animated: true)
    
    } else {
        
        showAlert(title:"Error!", message: "Wrong password", defaultAction: nil)
    }
    
    }

 private func checkPass() -> Bool{
    if let pass = UserDefaults.standard.value(forKey: Keys.pass.rawValue) as? String{
        print(pass)
        if pass == textField.text{
            return true
        } else {
            return false
        }
    }
    return false
}

private func showCreateNewVc() {
    guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "CreateViewController") as? CreateViewController else { return }
    present(controller, animated: true, completion: nil)
    
}



}
