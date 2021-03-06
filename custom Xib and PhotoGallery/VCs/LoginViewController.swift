//
//  LoginViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//
//MARK: Экран ввода пароля
import UIKit
import AudioToolbox
import WebKit
class LoginViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var showPassButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var greetingsGifImage: UIImageView!
    @IBOutlet weak var testGif: UIImageView!
    
    //MARK: Проверка нового пользователя
    
    var new = false {
        didSet {
            if new {
                 self.showCreateNewVc()
            }
        }
      }
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.isSecureTextEntry = true
        if UserDefaults.standard.value(forKey: Keys.pass.rawValue) == nil{
            new = true
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        
//        guard let handleGif = UIImageView.fromGif(frame: greetingsGifImage.frame, resourceName: "gif") else { return }
//         view.addSubview(handleGif)
//        handleGif.startAnimating()
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
////            confettiImageView.stopAnimating()
//                handleGif.removeFromSuperview()
//        }
        
        
//        let gifTapGesture = UITapGestureRecognizer(target: UIImageView.self, action: #selector(gifAnimate))
//gifTapGesture.cancelsTouchesInView = false
//view.addGestureRecognizer(gifTapGesture)
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.textFieldShouldEndEditing(_:)))
//        self.view.addGestureRecognizer(tapGesture)
//
        registerForKeyboardNotifications()

   }
    func animatedPassword() {
    guard let passwordGif = UIImageView.fromGif(frame: testGif.frame, resourceName: "eyeGif") else { return }
    view.addSubview(passwordGif)
    passwordGif.startAnimating()
    
    }
    
    //MARK: Прячем клавиатуру
    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
    
    //MARK: Func
    //show passwrod button
    @IBAction func showPassButtonPressed(_ sender: UIButton) {
//        textField.isSecureTextEntry = !textField.isSecureTextEntry
//        showPassButton.setImage(eye, for: .normal)
        
        sender.isSelected = !sender.isSelected
        if !sender.isSelected == true {
            animatedPassword()
        textField.isSecureTextEntry = true
    }
     else {
         testGif.stopAnimating()
        textField.isSecureTextEntry = false
    }
        }
        //forgot password
    @IBAction func password(_ sender: UIButton) {
        showCreateNewVc()
    }
    //Продолжить вход
    @IBAction func loginButtonPressed(_sender: UIButton) {
        if checkPass() {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ManagerViewController") as? ManagerViewController else {return}
            self.navigationController?.pushViewController(controller, animated: true)
    
    } else {
        //не знаю
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        //вибрация при ошибке
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        //алерт ошибки
        showAlert(title:"Error!", message: "Wrong password", defaultAction: nil)
    }
    }
//MARK: Подъем клавиатуры констрейном
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(_ notification: NSNotification) {
    
guard let userInfo = notification.userInfo,
    let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
                
                if notification.name == UIResponder.keyboardWillHideNotification {
                    bottomConstraint.constant = 0
                } else {
                    bottomConstraint.constant = keyboardScreenEndFrame.height + 10
                }
                
                view.needsUpdateConstraints()
                UIView.animate(withDuration: animationDuration) {
                    self.view.layoutIfNeeded()
                }
    }
    
    //MARK: Check password
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
    //MARK: Create New User
private func showCreateNewVc() {
    guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "CreateViewController") as? CreateViewController else { return }
    present(controller, animated: true, completion: nil)
    
}



}

//MARK: Проба браузера
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let webView = WKWebView.init(frame: view.frame)
//        view.addSubview(webView)
//        let adress = "https://www.vk.com"
//        guard let url = URL(string: adress) else { return }
//        let request = URLRequest(url: url)
//
//        webView.load(request)
//    }
