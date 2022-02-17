//
//  AddViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//

import UIKit

class AddViewController: UIViewController {
    //MARK: IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    //скрытие клавиатуры по тапу на экран
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        registerForKeyboardNotifications()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: Func
    //скрытие клавиатуры по тапу на экран
    @objc private func hideKeyboard(){
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
            
            view.needsUpdateConstraints()
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    
    // Вызвать алерт добавления фото
    @IBAction func addButtonPressed(_ sender: UIButton){
        ShowAlertActionSheet()
    }
    //Назад
    @IBAction func cancelButtonPressed(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
        //Сохранить фото в PhotoArray и закодировать
    @IBAction func saveButtonPressed (_ sender: UIButton){
        guard let image = imageView.image else {
            showAlert(title:"Ошибка", message: "Добавь фото", defaultAction: nil)
            return
        }
        //Запись значений
        guard let text = textField.text else { return }
        guard let imageName = saveImage(image: image) else { return }
        let photo = Photo(name: imageName, message: text)
            //Объявление массива фотографий записанного в UserDefaults
        if let array = UserDefaults.standard.value([Photo].self, forKey: Keys.photos.rawValue) {
    var tempArray = array
            //Добавление фотографии в массив
    tempArray.append(photo)
    UserDefaults.standard.set(encodable: tempArray, forKey: Keys.photos.rawValue)

        } else {
            let array: [Photo] = [photo]
            UserDefaults.standard.set(encodable: array, forKey: Keys.photos.rawValue)
        }
//Sucsess alert
        showAlert(title: "Отлично!", message: "Фото добавлено!") {
            self.imageView.image = nil
            self.textField.text = ""
        }
        
    }
    //MARK: Alert выбора
    private func ShowAlertActionSheet() {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Камера", style: .default) { _ in
            self.showPickerCamera(source: .front)
        }
        let library = UIAlertAction(title: "Фотоальбом", style: .default) { _ in
            self.showPicker(source: .photoLibrary)
            }
        let ok = UIAlertAction(title: "Отменить", style: .cancel) { _ in
            
        }

        alert.addAction(ok)
        alert.addAction(camera)
        alert.addAction(library)
        present(alert, animated: true,completion: nil)
    }
    //MARK: ShowPicker
    private func showPicker(source: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = source
        present(picker, animated: true,completion: nil)
        
    }
    private func showPickerCamera(source: UIImagePickerController.CameraDevice) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .camera
        present(picker, animated: true,completion: nil)
        
    }
    //MARK: SaveImage
    private func saveImage(image: UIImage) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } //путь к папке приложения на телефоне

        let fileName = UUID().uuidString
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return nil }
        
        
        //check if file exists, removes if it so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
            try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old images")
            } catch let error {
                print("couldn't remove file at path", error)
            }
    }
        //MARK: Save Error
        do {
            try data.write(to: fileURL)
            return fileName
        } catch let error {
            print("error saving file with error", error)
            return nil
        }
    }
}


