//
//  extension.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//

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
