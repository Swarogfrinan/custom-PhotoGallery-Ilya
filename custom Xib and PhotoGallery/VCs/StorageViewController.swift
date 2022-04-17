//
//  StorageViewController.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 11.02.2022.
//

import UIKit
//MARK: Хранилище фото

class StorageViewController: UIViewController {
    
    private enum Direction {
        case left, right
        
    }
    
    
    
    
    //MARK: IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    //индекс и оффсет подтягивание вьюшки после ухода клавиатуры.
    var index = 0
  lazy var offset = scrollView.contentOffset
    
    
    //MARK: PhotoArray
    var photosArray: [Photo]?
    var capacity = 1{
        didSet{
            if capacity == 0{
                showAlert(title: "No photos left", message: "Do not forget to add some") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    //MARK: current like
    var current = 0
    var liked: Bool = false{
        didSet{
            if liked{
                let image = UIImage(systemName: "suit.heart.fill")
                likeButton.setImage(image, for: .normal)
            } else {
                let image = UIImage(systemName: "suit.heart")
                likeButton.setImage(image, for: .normal)
            }
        }
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        imageView.image = loadImage(fileName: Manager.shared.photos[index].name)
        imageView.contentMode = .scaleAspectFit
        textField.text = Manager.shared.photos[index].message
//        styledButtons(buttons: arrowsButtons)
        loadDefault()
//let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.textFieldShouldEndEditing(_:)))
//    self.view.addGestureRecognizer(tapGesture)
        //MARK: Скрытие клавиатуры
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    override func viewDidAppear(_ animated: Bool) {
        offset = scrollView.contentOffset
    }
    
    
    
    
    @objc private func hideKeyboard(){
        textField.resignFirstResponder()
        view.endEditing(true)
    }
    //MARK:  ScrollView + textfield constraints.
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
                scrollView.contentOffset = offset
            } else {
                bottomConstraint.constant = keyboardScreenEndFrame.height + 10
            }
            
            view.needsUpdateConstraints()
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    
    
    
    
    //MARK: cancel action
    var cancelAction: (() -> ())?
    func configure(message:String, cancel: String, ok: String, okAction: (() -> ())? = nil, cancelAction: (() -> ())? = nil){
        
        textField.text = message
        deleteButton.setTitle(cancel, for: .normal)
        self.cancelAction = cancelAction
}
    
    //MARK: 03.Апрель починить
    private func buttonsPressed(direction: Direction) {
        
        switch direction {
        case .left:
            
            index = index == 0 ? Manager.shared.photos.count - 1 : index - 1
            
        case .right:
            
            index = index == Manager.shared.photos.count - 1 ? 0 : index + 1
        }
        
        let image = loadImage(fileName: Manager.shared.photos[index].name) ?? UIImage()
        
    }
    
     
    
    
    
    
    
    private func animatePicture(direction: Direction, image : UIImage) {
        guard var frame = imageView.superview?.frame else { return }
        frame.origin.y -= offset.y
        
        let aninatedView = UIImageView(frame: frame)
        aninatedView.contentMode = .scaleAspectFit
        aninatedView.image = image
        
        
        switch direction{
        case .left :
            aninatedView.frame.origin.x = -aninatedView.frame.width
        case .right :
            aninatedView.frame.origin.y = -view.frame.width
        }
        
        view.addSubview(aninatedView)
        
        UIView.animate(withDuration: 0.6) {
            self.imageView.alpha = 0
            aninatedView.frame.origin.x = frame.origin.x
        } completion: { _ in
            self.imageView.image = image
            self.imageView.alpha = 1
            aninatedView.removeFromSuperview()
        }
           
            
        }
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: Листание вправо
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        
        updateData()
        current = current < capacity - 1 ? current + 1 : 0
        
        guard capacity > 1 else {return}
        guard let photos = photosArray else {return}
        
        let slideView = UIImageView()
        slideView.frame = CGRect(x: self.view.frame.width, y: self.view.frame.origin.y, width: imageView.frame.width, height: imageView.frame.height)
        
        let photo = photos[current]
        guard let image = self.loadImage(fileName: photo.name) else {return}
        
        slideView.image = image
        liked = photo.isLiked
        textField.text = photo.message
        
        self.view.addSubview(slideView)
        likeButton.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            slideView.frame.origin.x = self.imageContainer.frame.origin.x
            self.likeButton.alpha = 1
        } completion: { _ in
            self.imageView.image = image
            slideView.removeFromSuperview()
        }
    }
        //MARK: Листание влево
    @IBAction func leftButtonPressed(_ sender: UIButton) {
            updateData()
            let slideView = UIImageView()
            slideView.frame = CGRect(origin: imageView.frame.origin, size: imageView.frame.size)
            slideView.image = imageView.image
            
            current = current > 0 ? current - 1 : capacity - 1
            
            guard capacity > 1 else {return}
            guard let photos = photosArray else { return }
            let photo = photos[current]
            
            //update info on page
            liked = photo.isLiked
            imageView.image = loadImage(fileName: photo.name)
            textField.text = photo.message
            //prepare for animation
            self.likeButton.alpha = 0
            self.imageContainer.addSubview(slideView)
            //animation
            UIView.animate(withDuration: 0.3) {
                slideView.frame.origin.x = -self.view.frame.width
                self.likeButton.alpha = 1
            } completion: { _ in
                slideView.removeFromSuperview()
            }
    }
        //смена состояния лайка
            @IBAction func likeButtonPressed(_ sender: UIButton) {
                let photos = Manager.shared.photos[index].name
                
                sender.isSelected = !sender.isSelected
                liked = !liked
            }
        //удаление фотографии
            @IBAction func deleteButtonPressed(_ sender: UIButton){
                self.showAlertDelete(title: "Delete photo", message: "Are your sure?", defaultAction: nil)
                self.delete()
                
            }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: загрузка изображения
private func loadImage(fileName: String) -> UIImage? {
    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    let imageUrl = documentsDirectory.appendingPathComponent(fileName)
let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
                }
    
             //MARK: загрузка стандартного фото
  private func loadDefault(){
      if let photos = UserDefaults.standard.value([Photo].self, forKey: Keys.photos.rawValue) {
//            value([Photo].self, forKey: Keys.photos.rawValue){
    photosArray = photos
    capacity = photos.count
    guard let photo = photos.first else { return }
        liked = photo.isLiked
            textField.text = photo.message
                let imageName = photo.name
                    guard let image = loadImage(fileName: imageName) else { return }
                                imageView.image = image
                            } else {
                                capacity = 0
                            }
                        }
    //обновляем дату в photosArray
    
                private func updateData() {
        guard let photo = photosArray?[current] else { return }
            guard let text = textField.text else { return }
photo.isLiked = liked
photo.message = text
UserDefaults.standard.set(encodable: photosArray, forKey: Keys.photos.rawValue)
}
    private func styledButtons(buttons:[UIButton]){
//                    for button in buttons{
//                button.rounded(radius: 10)
//                button.dropShadow()
//                    }
                    }
    private func delete(){
    guard let photo = self.photosArray?[self.current] else {return }
    self.photosArray = self.photosArray?.filter({$0.name != photo.name})
    
        //update foto in storage
    UserDefaults.standard.set(encodable: self.photosArray, forKey: Keys.photos.rawValue)
        self.capacity -= 1
    //update index
        current = current < capacity - 1 ? current + 1 : 0
            //check if slide is possible
        guard capacity > 0 else {return}
        guard let photos = photosArray else {return}
        //create animate view
            let slideView = UIImageView()
        slideView.frame = CGRect(x: self.view.frame.width, y: imageContainer.frame.origin.y, width: imageView.frame.width, height: imageView.frame.height)
                        // get next foto
                            let nextPhoto = photos[current]
                            guard let image = self.loadImage(fileName: nextPhoto.name) else { return }
                            slideView.image = image
                            //update info of screen
                            liked = nextPhoto.isLiked
                            textField.text = nextPhoto.message
                            
                            //prepare animation
                            self.view.addSubview(slideView)
                            likeButton.alpha = 0
                             //animation
                            UIView.animate(withDuration: 0.3) {
                                slideView.frame.origin.x = self.imageContainer.frame.origin.x
                                self.likeButton.alpha = 1
                            } completion: { _ in
                                self.imageView.image = image
                                slideView.removeFromSuperview()
                            }
                        }
                                            
                        }

                        
