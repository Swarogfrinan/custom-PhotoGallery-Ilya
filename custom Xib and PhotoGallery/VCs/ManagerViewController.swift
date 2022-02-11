//
//  ManagerViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//

import UIKit

class ManagerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func storageButtonPressed(_ sender: UIButton) {
        guard let controler = self.storyboard?.instantiateViewController(withIdentifier: "StorageViewController") as? StorageViewController else {return}
        self.navigationController?.pushViewController(controler, animated: true)
    }
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        guard let controler = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else {return }
        present(controler,animated: true, completion: nil)
    }
}
