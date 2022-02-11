//
//  ViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 10.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
//    @IBOutlet weak var imageView: UIImageView!
//    @IBAction func ButtonPressed(_sender: UIButton) {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = true
//        picker.sourceType = .photoLibrary
//        picker.delegate = self
//        present(picker, animated: true, completion: nil)
//
//    }
//    @IBAction func ShowXibButtonPressed(_sender: UIButton!) {
//        let myView = CustomView.instanceFromNib()
//        myView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//        myView.configure(message: "Attention!", cancel: "Nope", ok: "Sure") {
//            print("ok Works")
//        } cancelAction: {
//            print("cancel work")
//        }
//        self.view.addSubview(myView)
//    }
//}

//extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    private func ImagePickerControler(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
//                          info: [UIImagePickerController.InfoKey: Any]) {
//    var chosenImage = UIImage()
//    if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//        chosenImage = image
//    } else if let image = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
//        chosenImage = image
//    }
//    imageView.image = chosenImage
//    picker.dismiss(animated: true, completion: nil)
//}
}
