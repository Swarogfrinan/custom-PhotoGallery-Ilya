//
//  ViewXib.swift
//  custom Xib and PhotoGallery
//
//  Created by Ilya Vasilev on 10.02.2022.
//

import UIKit

class CustomView: UIView {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var okAction: (() -> ())?
    var cancelAction: (() -> ())?
    
    static func instanceFromNib() -> CustomView {
        return UINib(nibName: "CustomView", bundle: nil).instantiate(withOwner: nil, options:nil).first as! CustomView
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        if let myFunc = cancelAction{
            myFunc()
    }
        self.removeFromSuperview()
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        if let myFunc = okAction{
            myFunc()
    
        }
        self.removeFromSuperview()
    }
    func configure(message:String, cancel: String, ok: String, okAction: (() -> ())? = nil, cancelAction: (() -> ())? = nil){
        
        messageLabel.text = message
        cancelButton.setTitle(cancel, for: .normal)
        okButton.setTitle(ok, for: .normal)
        self.okAction = okAction
        self.cancelAction = cancelAction
    
}
}
