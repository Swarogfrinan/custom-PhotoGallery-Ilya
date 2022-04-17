//
//  UICollectionViewCellManager.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 03.04.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with image: UIImage?) {
        
        imageView.image = image

    }
    
    
}
