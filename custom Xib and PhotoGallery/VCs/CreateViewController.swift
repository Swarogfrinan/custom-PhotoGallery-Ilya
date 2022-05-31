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
    
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var ShowPasswordButton: UIButton!
    
    
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ///установка текущего времени в дата-пикере максимальным
        let date = Date()
        print(date.timeIntervalSince1970)
        datePicker.maximumDate = date
        
        //
//        labelGender.text = arrayGender.first
        registerForKeyboardNotifications()
        
        
            //MARK: Скрытие клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    //Функция скрытия клавиатуры по тапу на экран
    @objc private func hideKeyboard(){
        firstTextField.resignFirstResponder()
        view.endEditing(true)
    }
    //mark: 19 урок Пикер
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
        //подтягиваем констрейны
            view.needsUpdateConstraints()
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    

    
    
    let arrayGender = [
        "бесполый",
        "гермафродит",
         "мужеженственный (внутренне, по ощущениям)",
        " Bigender - ощущающие себя в разное время то мужчиной, то женщиной",
         "Cis Female - предженский, недоженский",
        "Cis Male - предмужской, недомужской",
        "Cis Man - предмужчина, недомужчина",
         "Cis Woman - предженщина, недоженщина",
         "Cisgender - предполовой, недополовой",
         "Cisgender Female - женский предпол, недополовой женский",
        "Cisgender Male",
        "Cisgender Man - предполовой мужчина, недополовой мужчина",
         "Cisgender Woman - предполовая женщина, недополовая женщина",
         "Female to Male - от женского к мужскому",
         "FTM - женщина, хирургически, внешне, принявшая облик мужчины",
        "Gender Fluid - неустойчивый, «текучий»",
         "Gender Nonconforming - отрицающий традиционную классификацию",
         "Gender Questioning - пол, остающийся под вопросом",
         "Gender Variant - пол, допускающий несколько вариантов",
         "Genderqueer - свой особенный, своеобычный",
         "Intersex - межполовой",
         "Male to Female - от мужчины к женщине",
         "MTF - мужчина, хирургически, внешне, принявший облик женщины",
        "Neither - ни тот, ни другой (из двух традиционных)",
        "Neutrois - стремящиеся устранить половые признаки во внешнем виде",
        "Non-binary - отрицающий систему двух полов",
 "Other - другое",
         "Pangender - всеобщеполовой",
         "Trans - переходной к другому полу",
         "Trans Female - переходной к женскому половому состоянию",
         "Trans Male - переходной к мужскому половому состоянию",
         "Trans Man - переходной к мужчине",
         "Trans Person - переходной к лицу, вне половой классификации",
         "Trans Woman - переходной к женщине",
         "Trans(asterisk) - переходной к другому полу (* - с сохранением тайны)",
         "Trans(asterisk)Female - переходной к женскому половому состоянию (*)",
         "Trans(asterisk)Male - переходной к мужскому половому состоянию(*)",
         "Trans(asterisk)Man - переходной к мужчине(*)",
         "Trans(asterisk)Person - переходной к лицу, вне половой классификации(*)",
        "Trans(asterisk)Woman - переходной к женщине(*)",
        "Transexual - транссексуальный",
        "Transexual Female - женский траннсексуальный",
        "Transexual Male - мужской транссексуальный",
   "Transexual Man - мужчина транссексуал",
"Transexual Person - лицо траннсексуал",
  "Transexual Woman - женщина транссексуал",
"Transgender Female",
"Transgender Male",
        "Transgender Man",
         "Transgender Person",
        "Transgender Woman",
         "Transmasculine - «за пределами мужского» (фантазии на тему мужского пола)",
        "Two-spirit - две души, «двудушный» (без негативной коннотации)"
    ]
    
    
    
    
    
    
    @IBAction func DateChanged(_ sender: UIDatePicker) {
        let date = sender.date
        print(date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM  yyyy "
        dateLabel.text = formatter.string(from: date)
    }
    
    
    //MARK: Func
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        if rulesToDo(){            UserDefaults.standard.setValue(firstTextField.text, forKey: Keys.pass.rawValue)
            dismiss(animated: true, completion: nil)
    }
    }
    
    //MARK: Скрыть пароль
    @IBAction func showPassButtonFirst(_ sender: UIButton) {
      sender.isSelected = !sender.isSelected
        if !sender.isSelected == true {
            ShowPasswordButton.backgroundColor = .white
        firstTextField.isSecureTextEntry = true
            secondTextField.isSecureTextEntry = true
    }
     else {
        firstTextField.isSecureTextEntry = false
         secondTextField.isSecureTextEntry = false
    }
        }
    
//    @IBAction func showPassButtonSecond(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if !sender.isSelected == true {
//        secondTextField.isSecureTextEntry = true
//    }
//     else {
//        secondTextField.isSecureTextEntry = false
//    }
//        }
    
    

    //MARK: Func что-то здесь сломано // уже не сломано
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

//MARK: 19 Занятие Picker
extension CreateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            ///количество барабанчиков в Пикере
            return 1
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ///Считает количество строк в Пикере
        return arrayGender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        ///Берет число строки и переводит в строку
        return arrayGender[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
//        labelGender.text = arrayGender[row]
    }
}

//extension CreateViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////     hidekeyboard()
//        view.endEditing(true)
//        return true
//    }
////
////    func hidekeyboard() {
////        self.firstTextField.resignFirstResponder()
////        self.secondTextField.resignFirstResponder()
//}
