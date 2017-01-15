//
//  attributesVC.swift
//  Foursquare Clone
//
//  Created by Atıl Samancıoğlu on 19/12/2016.
//  Copyright © 2016 Atıl Samancıoğlu. All rights reserved.
//

import UIKit

var name = ""
var type = ""
var atmosphere = ""
var image = UIImage()

class attributesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var atmosphereText: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(attributesVC.selectImage))
        placeImage.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func selectImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        placeImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        if nameText.text != "" {
            
            if let newImage = placeImage.image {
                name = nameText.text!
                type = typeText.text!
                atmosphere = atmosphereText.text!
                image = newImage
            }
            
        }
        
        
        
        self.performSegue(withIdentifier: "fromAttributestoLocationSegue", sender: nil)
        
        nameText.text = ""
        typeText.text = ""
        atmosphereText.text = ""
        self.placeImage.image = UIImage(named: "tapme.png")
    }
    
    
    
}
