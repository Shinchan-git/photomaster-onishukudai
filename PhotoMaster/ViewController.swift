//
//  ViewController.swift
//  PhotoMaster
//
//  Created by Owner on 2022/05/08.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onCameraButton() {
        presentPickerController(sourceType: .camera)
    }

    @IBAction func onAlbumButton() {
        //Deprecated
        presentPickerController(sourceType: .photoLibrary)
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        photoImageView.image = info[.originalImage] as? UIImage
    }
    
    @IBAction func onDrawTextButton() {
        if let image = photoImageView.image {
            photoImageView.image = drawText(image: image)
        } else {
            print("画像がありません")
        }
    }
    
    @IBAction func onDrawIllustrationButton() {
        if let image = photoImageView.image {
            photoImageView.image = drawMaskImage(image: image)
        } else {
            print("画像がありません")
        }
    }
    
    func drawText(image: UIImage) -> UIImage {
        let text = "Life is Tech !"
        let textFontAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Arial", size: 200)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 25.0
        let textRect = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func drawMaskImage(image: UIImage) -> UIImage {
        let maskImage = UIImage(named: "furo_ducky")!
        let maskImage2 = UIImage(named: "S__12279826")!
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width * 2 - margin, y: image.size.height - maskImage.size.height * 2 - margin, width: maskImage.size.width * 2, height: maskImage.size.height * 2)
        
        let maskRect2 = CGRect(x: image.size.width - maskImage2.size.width * 2 - margin, y: margin, width: maskImage2.size.width * 2, height: maskImage2.size.height * 2)
        
        maskImage.draw(in: maskRect)
        maskImage2.draw(in: maskRect2)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @IBAction func onUploadButton() {
        if let image = photoImageView.image {
            let activityVC = UIActivityViewController(activityItems: [image, "#PhotoMaster"], applicationActivities: nil)
            self.present(activityVC, animated: true)
        } else {
            print("画像がありません")
        }
    }
    
}

