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
}
extension UIViewController: UITextFieldDelegate {
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
