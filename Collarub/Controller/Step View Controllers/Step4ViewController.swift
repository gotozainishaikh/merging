//
//  Step4ViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 16/02/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GooglePlacesSearchController
import SwiftyJSON


class Step4ViewController: UIViewController, UITextViewDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var compyNam : String = ""
    var addrss : String = ""
    var descrptin : String = ""
    var whatoffring : String = ""
    var whatwillhv : String = ""
    var whatWont : String = ""
    var Primg1 : Data!
    var Primg2 : Data!
    var Primg3 : Data!
    var Loimg1 : Data!
    var Loimg2 : Data!
    var Loimg3 : Data!
    var e_mail : String = ""
    var telNo : String = ""
    var websit : String = ""
    var lat : String = ""
    var long : String = ""
    
    var imgname1 : URL!
    var imgname2 : URL!
    var imgname3 : URL!
    var imgname4 : URL!
    var imgname5 : URL!
    var imgname6 : URL!
    
    
    var img : Bool = false
    var img2 : Bool = false
    var img3 : Bool = false
    var loimg1 : Bool = false
    var loimg2 : Bool = false
    var loimg3 : Bool = false
    
    var picker = UIImagePickerController()
    
    @IBOutlet weak var wontHaveTo: UITextView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var offeringToinfluencer: UITextView!
    @IBOutlet weak var theyWillHave: UITextView!
        @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    
    @IBOutlet weak var locationImage1: UIButton!
    @IBOutlet weak var locationImage2: UIButton!
    @IBOutlet weak var locationImage3: UIButton!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var telephone: UITextField!
    @IBOutlet weak var websiteText: UITextField!
   
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

          NotificationCenter.default.addObserver(self, selector: #selector(rejectList(req_notification:)), name: NSNotification.Name(rawValue: "reqreject"), object: nil)
        
        buttonBorder(btn: image1)
        buttonBorder(btn: image2)
        buttonBorder(btn: image3)
        
        buttonBorder(btn: locationImage1)
        buttonBorder(btn: locationImage2)
        buttonBorder(btn: locationImage3)
        
        textBorder(vie: companyName)
        textBorder(vie: address)
        textBorder(vie: emailText)
        textBorder(vie: telephone)
        textBorder(vie: websiteText)
        
        textAreaBorder(vie: wontHaveTo)
        textAreaBorder(vie: descriptionText)
        textAreaBorder(vie: offeringToinfluencer)
        textAreaBorder(vie: theyWillHave)
        
//
//        picker.delegate = self
//        picker.sourceType = .camera
//        picker.allowsEditing = false
        
        
    }
    
    
    @objc func rejectList(req_notification: NSNotification) {
        var req_id : String = ""
        
        if let dict = req_notification.userInfo as NSDictionary? {
            if let id = dict["json"] as? JSON{
                print("zain shaikh :::: \(id[0]["collaboration_name"])")
                
                if let colName = id[0]["collaboration_name"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if colName != ""{
                        
                        self.compyNam = colName
                        companyName.text = colName
                        
                    }
                }
                
                if let colName = id[0]["collaboration_name"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if colName != ""{
                        
                        self.compyNam = colName
                        companyName.text = colName
                        
                    }
                }
                
                if let add = id[0]["address"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if add != ""{
                        
                        self.addrss = add
                        address.text = add
                        
                    }
                }
                
                if let des = id[0]["descriptions"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if des != ""{
                        
                        self.descrptin = des
                        descriptionText.text = des
                        
                    }
                }
                
                if let whtoffr = id[0]["what_u_offer"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if whtoffr != ""{
                        
                        self.whatoffring = whtoffr
                        offeringToinfluencer.text = whtoffr
                        
                    }
                }

                if let whthv = id[0]["wht_thy_hav_to_do"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if whthv != ""{
                        
                        self.whatwillhv = whthv
                        theyWillHave.text = whthv
                        
                    }
                }
                
                if let whtwnt = id[0]["wht_wont_hav_to"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if whtwnt != ""{
                        
                        self.whatWont = whtwnt
                        wontHaveTo.text = whtwnt
                        
                    }
                }
                
                if let emal = id[0]["e_mail"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if emal != ""{
                        
                        self.e_mail = emal
                        emailText.text = emal
                        
                    }
                }
                
                if let phne = id[0]["phone"].stringValue as? String{
                    //print("id :::: "+id)
                    // print("hosp_id="+hosp_id!)
                    
                    if phne != ""{
                        
                        self.telNo = phne
                        telephone.text = phne
                        
                    }
                }
                
                }
            }
        }
//    func selectImageFrom(_ source: ImageSource){
//        imagePicker =  UIImagePickerController()
//        imagePicker.delegate = self
//        switch source {
//        case .camera:
//            imagePicker.sourceType = .camera
//        case .photoLibrary:
//            imagePicker.sourceType = .photoLibrary
//        }
//        present(imagePicker, animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if img == true {
            
            guard let slectedImage = info[.originalImage] as? UIImage else {
                fatalError("Error in getting image")
                
            }
//
//            guard let fileUrl = info[.originalImage] as? URL else { return }
//            print("img name :: \(fileUrl.lastPathComponent)")
//
            
           
            
            // imgViewer.image = slectedImage
            // image1.setTitle("", for: .normal)
            print(slectedImage.pngData())
            let data = slectedImage.resizedTo1MB()
            Primg1 = data?.pngData()
            
            print("img :: \(Primg1)")
            
            
            image1.setBackgroundImage(slectedImage, for: .normal)
            image1.setTitle("", for: .normal)
            
            img = false
        }
        
        if img2 == true {
            guard let slectedImage = info[.originalImage] as? UIImage else {
                fatalError("Error in getting image")
                
            }
            
            
             print(slectedImage.pngData())
            let data = slectedImage.resizedTo1MB()
            Primg2 = data?.pngData()
            
            print("img :: \(Primg2)")
            
            // imgViewer.image = slectedImage
            // image1.setTitle("", for: .normal)
            
            
            image2.setBackgroundImage(slectedImage, for: .normal)
            image2.setTitle("", for: .normal)
            
            img2 = false
        }
        
        if img3 == true {
            guard let slectedImage = info[.originalImage] as? UIImage else {
                fatalError("Error in getting image")
                
            }
            
            
             print(slectedImage.pngData())
            let data = slectedImage.resizedTo1MB()
            Primg3 = data?.pngData()
            
            print("img :: \(Primg3)")
            
            // imgViewer.image = slectedImage
            // image1.setTitle("", for: .normal)
            
            
            image3.setBackgroundImage(slectedImage, for: .normal)
            image3.setTitle("", for: .normal)
            
            img3 = false
        }
        
        if loimg1 == true {
            guard let slectedImage = info[.originalImage] as? UIImage else {
                fatalError("Error in getting image")
                
            }
            
             print(slectedImage.pngData())
            let data = slectedImage.resizedTo1MB()
            Loimg1 = data?.pngData()
            
            print("img :: \(Loimg1)")
            
            // imgViewer.image = slectedImage
            // image1.setTitle("", for: .normal)
            
            
            locationImage1.setBackgroundImage(slectedImage, for: .normal)
            locationImage1.setTitle("", for: .normal)
            
            loimg1 = false
        }
        
        if loimg2 == true {
            guard let slectedImage = info[.originalImage] as? UIImage else {
                fatalError("Error in getting image")
                
            }
            
             print(slectedImage.pngData())
            let data = slectedImage.resizedTo1MB()
            Loimg2 = data?.pngData()
            
            print("img :: \(Loimg2)")
            
            
            
            // imgViewer.image = slectedImage
            // image1.setTitle("", for: .normal)
            
            
            locationImage2.setBackgroundImage(slectedImage, for: .normal)
            locationImage2.setTitle("", for: .normal)
            
            loimg2 = false
        }
        
        if loimg3 == true {
            guard let slectedImage = info[.originalImage] as? UIImage else {
                fatalError("Error in getting image")
                
            }
            
            
             print(slectedImage.pngData())
            let data = slectedImage.resizedTo1MB()
            Loimg3 = data?.pngData()
            
            print("img :: \(Loimg3)")
            
            
            // imgViewer.image = slectedImage
            // image1.setTitle("", for: .normal)
            
            
            locationImage3.setBackgroundImage(slectedImage, for: .normal)
            locationImage3.setTitle("", for: .normal)
          //  print("image :: \(slectedImage)")
            
           
//            let url:NSURL = NSURL(string : "urlHere")!
//            let imageData:NSData = NSData.init(contentsOfURL: url as URL)!
//
//           let data = UIImage.jpegData(slectedImage)
//            print(data)
            loimg3 = false
        }
        
        
        
        
      //  guard let ciimage = CIImage(image: slectedImage) else {
       //     fatalError("Error in converting cimage")
       // }
        
        picker.dismiss(animated: true, completion: nil)
        
      //  detect(ciimage: ciimage)
        
    }
    
    func textBorder(vie:UITextField){
        vie.layer.borderWidth = 1
        vie.layer.borderColor = UIColor.white.cgColor
    }
    
    func textAreaBorder(vie:UITextView){
        vie.layer.borderWidth = 1
        vie.layer.borderColor = UIColor.white.cgColor
    }


    func buttonBorder(btn:UIButton){
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func tapImag1(_ sender: UIButton) {
        // present(picker, animated: true, completion: nil)
        //optionShet(im : img)
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Gallary", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.picker.delegate = self
            self.picker.sourceType = .photoLibrary
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            
//            var imm = im
//            imm = true
            //imm = "sad"

            self.img = true
            
            print("Gallary")
        })
        
        let deleteAction = UIAlertAction(title: "Camera", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            self.picker.delegate = self
            self.picker.sourceType = .camera
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
//            var imm = im
//            imm = true
            //  im = true
            self.img = true
            
            print("Camera")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    
    }
    
    
    @IBAction func tapImag2(_ sender: UIButton) {
        
        //optionShet(im : self.img2)
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Gallary", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.picker.delegate = self
            self.picker.sourceType = .photoLibrary
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            
            //            var imm = im
            //            imm = true
            //imm = "sad"
            
            self.img2 = true
            
            print("Gallary")
        })
        
        let deleteAction = UIAlertAction(title: "Camera", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            self.picker.delegate = self
            self.picker.sourceType = .camera
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            //            var imm = im
            //            imm = true
            //  im = true
            self.img2 = true
            
            print("Camera")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    
    @IBAction func tapImag3(_ sender: UIButton) {
        
       //  optionShet(im : img3)
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Gallary", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.picker.delegate = self
            self.picker.sourceType = .photoLibrary
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            
            //            var imm = im
            //            imm = true
            //imm = "sad"
            
            self.img3 = true
            
            print("Gallary")
        })
        
        let deleteAction = UIAlertAction(title: "Camera", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            self.picker.delegate = self
            self.picker.sourceType = .camera
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            //            var imm = im
            //            imm = true
            //  im = true
            self.img3 = true
            
            print("Camera")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
        
    }
    
    @IBAction func LoImag1(_ sender: UIButton) {
        
       // optionShet(im : loimg1)
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Gallary", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.picker.delegate = self
            self.picker.sourceType = .photoLibrary
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            
            //            var imm = im
            //            imm = true
            //imm = "sad"
            
            self.loimg1 = true
            
            print("Gallary")
        })
        
        let deleteAction = UIAlertAction(title: "Camera", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            self.picker.delegate = self
            self.picker.sourceType = .camera
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            //            var imm = im
            //            imm = true
            //  im = true
            self.loimg1 = true
            
            print("Camera")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func LoImag2(_ sender: UIButton) {
        
       // optionShet(im : loimg2)
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Gallary", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.picker.delegate = self
            self.picker.sourceType = .photoLibrary
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            
            //            var imm = im
            //            imm = true
            //imm = "sad"
            
            self.loimg2 = true
            
            print("Gallary")
        })
        
        let deleteAction = UIAlertAction(title: "Camera", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            self.picker.delegate = self
            self.picker.sourceType = .camera
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            //            var imm = im
            //            imm = true
            //  im = true
            self.loimg2 = true
            
            print("Camera")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    @IBAction func LoImag3(_ sender: UIButton) {
      //  optionShet(im : loimg3)
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Gallary", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.picker.delegate = self
            self.picker.sourceType = .photoLibrary
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            
            //            var imm = im
            //            imm = true
            //imm = "sad"
            
            self.loimg3 = true
            
            print("Gallary")
        })
        
        let deleteAction = UIAlertAction(title: "Camera", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            self.picker.delegate = self
            self.picker.sourceType = .camera
            self.picker.allowsEditing = false
            self.present(self.picker, animated: true, completion: nil)
            //            var imm = im
            //            imm = true
            //  im = true
            self.loimg3 = true
            
            print("Camera")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    @IBAction func cmpNme(_ sender: UITextField) {
        
        compyNam = sender.text!
        print(compyNam)
    }
    
    @IBAction func addRsTxt(_ sender: UITextField) {
        
        addrss = sender.text!
        print(addrss)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
    
        
            descrptin = descriptionText.text!
         //   print(descrptin)
        
        whatoffring = offeringToinfluencer.text!
     //   print(whatoffring)
        whatwillhv = theyWillHave.text!
        whatWont = wontHaveTo.text!
        
        
        
    }
    
    @IBAction func web(_ sender: UITextField) {
        websit = sender.text!
    }
    
    @IBAction func telphn(_ sender: UITextField) {
        telNo = sender.text!
    }
    
    @IBAction func email(_ sender: UITextField) {
        e_mail = sender.text!
        
    }
    
    let GoogleMapsAPIServerKey = "AIzaSyCp93QINHvSoa0pdd1jK-oOsCZsZjAeQVI"
    
    lazy var placesSearchController: GooglePlacesSearchController = {
        let controller = GooglePlacesSearchController(delegate: self,
                                                      apiKey: GoogleMapsAPIServerKey,
                                                      placeType: .address
            // Optional: coordinate: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423),
            // Optional: radius: 10,
            // Optional: strictBounds: true,
            // Optional: searchBarPlaceholder: "Start typing..."
        )
        //Optional: controller.searchBar.isTranslucent = false
        //Optional: controller.searchBar.barStyle = .black
        //Optional: controller.searchBar.tintColor = .white
        //Optional: controller.searchBar.barTintColor = .black
        return controller
    }()

    
    @IBAction func localAddress(_ sender: UITextField) {
       
        present(placesSearchController, animated: true, completion: nil)
        
        }
        
    }


extension Step4ViewController: GooglePlacesAutocompleteViewControllerDelegate {
    func viewController(didAutocompleteWith place: PlaceDetails) {
        print(place.description)
        lat = "\((place.coordinate?.latitude)!)"
        long = "\((place.coordinate?.longitude)!)"
        print("\(lat), \(long)")
        address.text = place.name
        addrss = place.name!
        
        placesSearchController.isActive = false
    }
}

extension UIImage {
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: 240, height: 120)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizedTo1MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        
        while imageSizeKB > 1000 { // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
                let imageData = resizedImage.pngData()
                else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        }
        
        return resizingImage
    }
}
