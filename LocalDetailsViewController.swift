//
//  LocalDetailsViewController.swift
//  Collarub
//
//  Created by Mac 1 on 10/17/1397 AP.
//  Copyright © 1397 Mac 1. All rights reserved.
//

import UIKit
import SDWebImage
import ImageSlideshow


class LocalDetailsViewController: UIViewController {

    @IBOutlet weak var slider: ImageSlideshow!
    let localSource = [ImageSource(imageString: "modelimg")!, ImageSource(imageString: "bgImg")!, ImageSource(imageString: "modelimg")!]
    
    
    

    
    
    @IBOutlet weak var advertisementTitle: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var advertisementDescription: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var reviewerDescription: UILabel!
    @IBOutlet weak var collaborationTerm: UILabel!
    @IBOutlet weak var numOfFollowers: UILabel!
    
    @IBOutlet weak var ACCPTBUGT: UIButton!
    
    var detailsArray : LocalModel?
    var onlineArray : OnlineModel?
    var statArray : StatusTableModel?
    var modelCustom : customAnnoation?
    var favArray : FavListModel?
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    @objc func didTap() {
        slider.presentFullScreenController(from: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        localDetails()
        
        ACCPTBUGT.layer.borderColor = UIColor(named: "themecolor4")?.cgColor
        ACCPTBUGT.layer.borderWidth = 0.5
        uiNavegationImage()
        
   //     UINavigationBar.appearance().tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        // Do any additional setup after loading the view.
    }
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    

    func detail(array:[AnyClass]){
        
    }
    
    func localDetails(){
        
        let sdWebImageSource = [SDWebImageSource(urlString: (detailsArray?.productImage[0])!)!, SDWebImageSource(urlString: (detailsArray?.productImage[1])!)!, SDWebImageSource(urlString: (detailsArray?.productImage[2])!)!, SDWebImageSource(urlString: (detailsArray?.productImage[3])!), SDWebImageSource(urlString: (detailsArray?.productImage[4])!), SDWebImageSource(urlString: (detailsArray?.productImage[5])!)]
        
        slider.slideshowInterval = 5.0
        slider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slider.contentScaleMode = UIView.ContentMode.scaleAspectFill
        print("\(detailsArray?.selectedNumOfFollowers)")
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        slider.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slider.activityIndicator = DefaultActivityIndicator()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        slider.addGestureRecognizer(gestureRecognizer)
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slider.setImageInputs(sdWebImageSource as! [InputSource])
        
        
//        if (detailsArray != nil) {
//            image1.sd_setImage(with: URL(string: (detailsArray?.productImage[0])!))
//            image2.sd_setImage(with: URL(string: (detailsArray?.productImage[1])!))
//            image3.sd_setImage(with: URL(string: (detailsArray?.productImage[2])!))
//            advertisementTitle.text = detailsArray?.title
//            companyName.text = detailsArray?.companyName
//            location.text = detailsArray?.location
//            date.text = detailsArray?.date
//            advertisementDescription.text = detailsArray?.description
//            collaborationTerm.text = detailsArray?.collaborattionTerms
//            numOfFollowers.text = detailsArray?.selectedNumOfFollowers
//        } else if (onlineArray != nil){
//            image1.sd_setImage(with: URL(string: (onlineArray?.productImage[0])!))
//            image2.sd_setImage(with: URL(string: (onlineArray?.productImage[1])!))
//            image3.sd_setImage(with: URL(string: (onlineArray?.productImage[2])!))
//            advertisementTitle.text = onlineArray?.title
//            companyName.text = onlineArray?.companyName
//            location.text = onlineArray?.location
//            date.text = onlineArray?.date
//            advertisementDescription.text = onlineArray?.description
//            collaborationTerm.text = onlineArray?.collaborattionTerms
//            numOfFollowers.text = onlineArray?.selectedNumOfFollowers
//        }else if (modelCustom != nil){
//            image1.sd_setImage(with: URL(string: (modelCustom?.productImage[0])!))
//            image2.sd_setImage(with: URL(string: (modelCustom?.productImage[1])!))
//            image3.sd_setImage(with: URL(string: (modelCustom?.productImage[2])!))
//            advertisementTitle.text = modelCustom?.title
//            companyName.text = modelCustom?.companyName
//            location.text = modelCustom?.location
//            date.text = modelCustom?.date
//            advertisementDescription.text = modelCustom?.description1
//            collaborationTerm.text = modelCustom?.collaborattionTerms
//            numOfFollowers.text = modelCustom?.selectedNumOfFollowers
//        }else if (statArray != nil) {
//
//            image1.sd_setImage(with: URL(string: (statArray?.productImage[0])!))
//            image2.sd_setImage(with: URL(string: (statArray?.productImage[1])!))
//            image3.sd_setImage(with: URL(string: (statArray?.productImage[2])!))
//            advertisementTitle.text = statArray?.title
//            companyName.text = statArray?.companyName
//            location.text = statArray?.location
//            date.text = statArray?.date
//            advertisementDescription.text = statArray?.description
//            collaborationTerm.text = statArray?.collaborattionTerms
//            numOfFollowers.text = statArray?.selectedNumOfFollowers
//
//        }else if (favArray != nil) {
//
//            image1.sd_setImage(with: URL(string: (favArray?.productImage[0])!))
//            image2.sd_setImage(with: URL(string: (favArray?.productImage[1])!))
//            image3.sd_setImage(with: URL(string: (favArray?.productImage[2])!))
//            advertisementTitle.text = favArray?.title
//            companyName.text = favArray?.companyName
//            location.text = favArray?.location
//            date.text = favArray?.date
//            advertisementDescription.text = favArray?.description
//            collaborationTerm.text = favArray?.collaborattionTerms
//            numOfFollowers.text = favArray?.selectedNumOfFollowers
//
//        }
        
    }

}
