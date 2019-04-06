////
////  Extensions.swift
////  Tabadul
////
////  Created by Farooq on 8/5/17.
////  Copyright © 2017 Majeed Bhai. All rights reserved.
////
//
//
//import UIKit
//
//
//extension UIViewController{
//    
//    func showAlert(title: String!, message: String! , completion: (()->())? = nil){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
//            
//            if let complete = completion{
//                
//                complete()
//            }
//        }
//        alert.addAction(okAction)
//        self.present(alert, animated: true, completion: nil)
//    }
//    func hideKeyboard(){
//        
//        self.view.endEditing(true)
//    }
//    
//}
//
////extension Int{
////    
////    var converToString : String{
////        
////        get{
////            
////            return String(self)
////            
////            
////        }
////        
////        
////    }
////    
////    
////    
////}
//extension Double{
//    
//    var converToString : String{
//        
//        get{
//            return String(self)
//        }
//    }
//}
//
//extension String{
////    var arabicImageFromJsonString: String{
////        get{
////            if let json = self.parseJSONString as? NSDictionary{
////                print(json ?? "invalid json string")
////                let dic = json.allValues as? [NSDictionary]
////                
////                return Constants.imageUrl + ((dic?.first!["arabic_filename"] ?? "" )as? String)!
////                
////            }else{
////                return self
////            }
////            
////            
////        }
////        
////    }
////    var imageFromJsonString: String{
////        get{
////            if let json = self.parseJSONString as? NSDictionary{
////                print(json ?? "invalid json string")
////                let dic = json.allValues as? [NSDictionary]
////                
////                return Constants.imageUrl + ((dic?.first!["filename"] ?? "" )as? String)!
////                
////            }else{
////                return self
////            }
////            
////            
////        }
////        
////    }
//    var converToDouble : Double{
//        
//        get{
//            return Double(self)!
//        }
//    }
//    
//    var isPhoneNumber: Bool {
//        do {
//            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
//            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
//            if let res = matches.first {
//                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.characters.count
//            } else {
//                return false
//            }
//        } catch {
//            return false
//        }
//    }
//    
//    //To check text field or String is blank or not
//    var isBlank: Bool {
//        get {
//            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
//            return trimmed.isEmpty
//        }
//    }
//    
//    //Validate Email
//    var isEmail: Bool {
//        do {
//            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
//            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
//        } catch {
//            return false
//        }
//    }
//    
//    var isAlphanumeric: Bool {
//        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
//    }
//    
//    //validate Password
//    var isValidPassword: Bool {
//        do {
//            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
//            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
//                
//                if(self.characters.count>=6 && self.characters.count<=20){
//                    return true
//                }else{
//                    return false
//                }
//            }else{
//                return false
//            }
//        } catch {
//            return false
//        }
//    }
//
//    
////    public func imageFromUrl( completion: @escaping (_ data:UIImage?)->()){
////        
////        if let url = URL(string: self){
////            
////            SDWebImageManager.shared().downloadImage(with: url, options: SDWebImageOptions.cacheMemoryOnly, progress: { (size, totalSize) in
////                
////            }, completed: { (image, error, cache, someBool, imageUrl) in
////                
////                if let img = image{
////                    
////                    completion(img)
////                    
////                }else{
////                    
////                    completion(#imageLiteral(resourceName: "addphoto"))
////                }
////            })
////        }
////    }
//    
//}
//
//
////Load Nib
//extension UIView {
//    
//    public class func fromNib() -> Self {
//        return fromNib(nibName: nil)
//    }
//    public class func fromNib(nibName: String?) -> Self {
//        func fromNibHelper<T>(nibName: String?) -> T where T : UIView {
//            let bundle = Bundle(for: T.self)
//            let name = nibName ?? String(describing: T.self)
//            return bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? T ?? T()
//        }
//        return fromNibHelper(nibName: nibName)
//    }
//}
//
//extension Array {
//    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
//        var set = Set<T>() //the unique list kept in a Set for fast retrieval
//        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
//        for value in self {
//            if !set.contains(map(value)) {
//                set.insert(map(value))
//                arrayOrdered.append(value)
//            }
//        }
//        return arrayOrdered
//    }
//}
//
//extension Sequence where Iterator.Element: Hashable {
//    func unique() -> [Iterator.Element] {
//        var seen: [Iterator.Element: Bool] = [:]
//        return self.filter { seen.updateValue(true, forKey: $0) == nil }
//    }
//}
//
//extension Array{
//    
//    func convertToNSData() -> Data{
//        
//        let data = NSKeyedArchiver.archivedData(withRootObject: self)
//        return data
//        /*  let stringsData = NSMutableData()
//         for string in self{
//         
//         if let stringData = (string as? String)?.data(using: String.Encoding.utf8) {
//         
//         stringsData.append(stringData)
//         
//         } else {
//         
//         NSLog("Uh oh, trouble!")
//         
//         }
//         
//         }
//         
//         return stringsData as Data*/
//    }
//}
//
//extension String {
//    
//    func slice(from: String, to: String) -> String? {
//        
//        return (range(of: from)?.upperBound).flatMap { substringFrom in
//            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
//                substring(with: substringFrom..<substringTo)
//            }
//        }
//    }
//    
//    var converToInt : Int{
//        
//        get{
//            return Int(self)!
//        }
//    }
//}
//
//extension UIImage{
//
//        func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//            let size = image.size
//            
//            let widthRatio  = targetSize.width  / image.size.width
//            let heightRatio = targetSize.height / image.size.height
//            
//            // Figure out what our orientation is, and use that to form the rectangle
//            var newSize: CGSize
//            if(widthRatio > heightRatio) {
//                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//            } else {
//                newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//            }
//            
//            // This is the rect that we've calculated out and this is what is actually used below
//            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
//            
//            // Actually do the resizing to the rect using the ImageContext stuff
//            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//            image.draw(in: rect)
//            let newImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            return newImage!
//        }
//    
//    func imageRotatedByDegrees( deg degrees: CGFloat) -> UIImage {
//        //Calculate the size of the rotated view's containing box for our drawing space
//        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
//        let t: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
//        rotatedViewBox.transform = t
//        let rotatedSize: CGSize = rotatedViewBox.frame.size
//        //Create the bitmap context
//        UIGraphicsBeginImageContext(rotatedSize)
//        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
//        //Move the origin to the middle of the image so we will rotate and scale around the center.
//        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
//        //Rotate the image context
//        bitmap.rotate(by: (degrees * CGFloat.pi / 180))
//        //Now, draw the rotated/scaled image into the context
//        bitmap.scaleBy(x: 1.0, y: -1.0)
//        bitmap.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
//        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return newImage
//    }
//    
//    func convertToBase64String(image: UIImage) -> String{
//        
//        let imageData = UIImagePNGRepresentation(image)
//        let base64String = imageData?.base64EncodedString()
//        return base64String!
//    
//    }
//    
//    
//}
//extension UITextField {
//    
//    func removeSpaces(_ text: String){
//        text.replacingOccurrences(of: " ", with: "+")
//    }
//    
//    func addSpaces(_ text: String){
//        text.replacingOccurrences(of: "+", with: " ")
//    }
//    
//    func setLeftPaddingPoints(_ amount:CGFloat){
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        self.leftView = paddingView
//        self.leftViewMode = .always
//    }
//    
//    func underlined(){
//        let border = CALayer()
//        let width = CGFloat(1.0)
//        border.borderColor = UIColor.lightGray.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = width
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }
//}
//
//extension Int{
//    var converToString : String{
//        get{
//            return String(self)
//        }
//    }
//}
//
//extension UIView {
//    
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//    
//    
//    
//    @IBInspectable var borderColor: UIColor? {
//        get {
//            return UIColor(cgColor: layer.borderColor!)
//        }
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//    }
//}
//
//extension UITableView{
//    func reloadWithAnimation() {
//        
//        DispatchQueue.main.async {
//            self.reloadData()
//            
//            let cells = self.visibleCells
//            let tableHeight: CGFloat = self.bounds.size.height
//            
//            for i in cells {
//                let cell: UITableViewCell = i as UITableViewCell
//                cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
//            }
//            
//            var index = 0
//            
//            for cell in cells {
//                let cell: UITableViewCell = cell as UITableViewCell
//                UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
//                    cell.transform = CGAffineTransform(translationX: 0, y: 0);
//                }, completion: nil)
//                
//                index += 1
//            }
//        }
//    }
//}
//
//extension String {
//    var replaceSpaceWithPlus : String{
//        
//        get{
//            return self.replacingOccurrences(of: " ", with: "+")
//        }
//    }
//}
//extension UIColor {
//    convenience init(hexString: String) {
//        let hex = hexString.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
//        
//        var int = UInt32()
//        Scanner(string: hex).scanHexInt32(&int)
//        let a, r, g, b: UInt32
//        switch hex.characters.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (0,0, 0, 0)
//        }
//        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
//    }
//    convenience init(hexString: String, alpha : CGFloat) {
//        let hex = hexString.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
//        
//        var int = UInt32()
//        Scanner(string: hex).scanHexInt32(&int)
//        let a, r, g, b: UInt32
//        switch hex.characters.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (0,0, 0, 0)
//        }
//        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
//    }
//    
//}
//extension UITextField{
//    @IBInspectable var placeHolderColor: UIColor? {
//        get {
//            return self.placeHolderColor
//        }
//        set {
//            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
//        }
//    }
//}
//extension String
//{
//    var parseJSONString: AnyObject?
//    {
//        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
//        
//        if let jsonData = data
//        {
//            // Will return an object or nil if JSON decoding fails
//            do
//            {
//                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
//                if let jsonResult = message as? NSMutableArray {
//                    return jsonResult //Will return the json array output
//                } else if let jsonResult = message as? NSMutableDictionary {
//                    return jsonResult //Will return the json dictionary output
//                } else {
//                    return nil
//                }
//            }
//            catch let error as NSError
//            {
//                print("An error occurred: \(error)")
//                return nil
//            }
//        }
//        else
//        {
//            // Lossless conversion of the string was not possible
//            return nil
//        }
//}
//}
//extension UIView {
//    func fadeIn() {
//        // Move our fade out code from earlier
//        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
//        }, completion: nil)
//    }
//    
//    func fadeOut() {
//        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//            self.alpha = 0.0
//        }, completion: nil)
//    }
//}
//extension String{
//    func toDate(format : String) -> Date{
//        let dateFormatter = DateFormatter()
//        
//        dateFormatter.dateFormat = format
//        return dateFormatter.date(from: self)!
//    }
//}
