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
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.textFieldShouldEndEditing(_:)))
//        self.view.addGestureRecognizer(tapGesture)
    }
    //MARK: Func
    @IBAction func addButtonPressed(_ sender: UIButton){
        ShowAlertActionSheet()
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed (_ sender: UIButton){
        guard let image = imageView.image else {
            showAlert(title:"Error", message: "Empty image", defaultAction: nil)
            return
        }
        guard let text = textField.text else { return }
        guard let imageName = saveImage(image: image) else { return }
        let photo = Photo(name: imageName, message: text)

        if let array = UserDefaults.standard.value([Photo].self, forKey: Keys.photos.rawValue) {
    var tempArray = array
    tempArray.append(photo)
    UserDefaults.standard.set(encodable: tempArray, forKey: Keys.photos.rawValue)

        } else {
            let array: [Photo] = [photo]
            UserDefaults.standard.set(encodable: array, forKey: Keys.photos.rawValue)
        }

        showAlert(title: "Succes!", message: "Photo saved!") {
            self.imageView.image = nil
            self.textField.text = ""
        }
        
    }
    //MARK: Alert выбора
    private func ShowAlertActionSheet() {
        let alert = UIAlertController(title: "add photo", message: "Choose source", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.showPicker(source: .camera)
        }
        let library = UIAlertAction(title: "Library", style: .default) { _ in
            self.showPicker(source: .photoLibrary)
        }
        alert.addAction(camera)
        alert.addAction(library)
        present(alert, animated: true,completion: nil)
    }
    //MARK: ShowPicker
    private func showPicker(source: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = source
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


