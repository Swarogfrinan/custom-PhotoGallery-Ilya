//
//  ManagerViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//

import UIKit

//MARK: Переход в хранилище фотографий или же их добавление
class ManagerViewController: UIViewController {
    
    @IBOutlet weak var greetingsGifImage: UIImageView!
    @IBOutlet weak var storageButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        do {
//            let gif = try UIImage(gifName: "gif.gif")
//            let imageview = UIImageView(gifImage: gif, loopCount: 3) // Will loop 3 times
//            imageview.frame = view.bounds
//            view.addSubview(imageview)
//        } catch {
//            print(error)
//        }
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
