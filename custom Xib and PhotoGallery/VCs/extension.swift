//
//  extension.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//
//MARK: Extension Alert standart
import Foundation
import UIKit
extension UIViewController {
    func showAlert(defaultTitle: String = "OK", title : String, message : String, defaultAction: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: defaultTitle, style: .default) { _ in
            guard let action = defaultAction else {return}
            action()
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertDelete(defaultTitle: String = "Delete", title : String, message : String, defaultAction: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: defaultTitle, style: .cancel) { _ in
            guard let action = defaultAction else {return}
            action()
        }
        
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
    }
    
}

extension CreateViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
//extension CreateViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//     hidekeyboard()
//        return true
//    }
//    func hidekeyboard() {
//        firstTextField.resignFirstResponder()
//
//extension LoginViewController: UITextFieldDelegate {
//    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//     hidekeyboard()
//        return true
//    }
//    func hidekeyboard() {
//        self.textField.resignFirstResponder()
//}

//}
//extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//    var choosenImage = UIImage()
//        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//        choosenImage = image
//        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            choosenImage = image
//        }
//}
//}

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key: String) {
    if let data = try? JSONEncoder().encode (encodable) {
    set(data, forKey: key)
    }
    }
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
    if let data = object (forKey: key) as? Data,
    let value = try? JSONDecoder().decode(type, from: data) {
    return value
    }
        return nil
    }
}




//MARK: AddView delegate
extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
                               info: [UIImagePickerController.InfoKey : Any]) {
        var choosenImage = UIImage()
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            choosenImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            choosenImage = image
        }
        imageView.image = choosenImage
        blurView.isHidden = true
        picker.dismiss(animated: true, completion: nil)
    }
}


