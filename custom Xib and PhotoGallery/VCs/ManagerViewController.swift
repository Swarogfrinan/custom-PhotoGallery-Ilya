//
//  ManagerViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//

import UIKit

//MARK: Переход в хранилище фотографий или же их добавление
class ManagerViewController: UIViewController {
    
//    @IBOutlet weak var greetingsGifImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var storageButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    collectionView.reloadData()
    }
    
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
//    func chobluat() {
//        var greetImage = UIImage(named: "gif")
//        self.greetingsGifImage.image = greetImage
//    }
    
    @IBAction func storageButtonPressed(_ sender: UIButton) {
        guard let controler = self.storyboard?.instantiateViewController(withIdentifier: "StorageViewController") as? StorageViewController else {return}
        controler.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controler, animated: true)
        
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        guard let controler = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else {return }
        controler.modalPresentationStyle = .fullScreen
        controler.delegate = self
        present(controler,animated: true, completion: nil)
    }
    

   
    
    
      
}
// MARK: - Extension + ManagerViewController
extension ManagerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func didSelectPhotoToStorage(forIndex index: Int) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "StorageViewController") as? StorageViewController else { return }
        controller.index = index
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func didAddNewPhoto() {
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Manager.shared.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: UIImage)
        cell.delegate = self
//
        return cell
        
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = ( collectionView.frame.width - 10 ) / 2
        return CGSize(width: side, height: side)
    }
}
