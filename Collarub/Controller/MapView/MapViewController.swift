//
//  MapViewController.swift
//  Collarub
//
//  Created by Zain Shaikh on 10/01/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import MapKit
import PopupWindow
import SDWebImage

class MapViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {

    
    
    var modelAnnoation = customAnnoation()
    
    @IBOutlet weak var numOfFollowers: UILabel!
    @IBOutlet weak var imgCollabrub: UIImageView!
    @IBOutlet weak var collabrubTitle: UILabel!
    @IBOutlet weak var collabrubDescrip: UILabel!
    @IBOutlet weak var btnCollabrub: UIButton!
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    var model : [LocalModel] = [LocalModel]()
    var modelElement = LocalModel()
    @IBOutlet weak var searchbar: UISearchBar!
    let locations = [
        ["title": "Maji Hospital",    "latitude": 25.381930, "longitude": 68.373040],
        ["title": "Thandi Sarak", "latitude": 25.381930, "longitude": 68.373040],
        ["title": "Pervez Motors",     "latitude": 25.381930, "longitude": 68.373040],["title": "Madina Masjid",     "latitude": 25.381484, "longitude": 68.374286]
    ]

    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var otherLocation = CLLocationCoordinate2D()
    override func viewDidLoad() {
        super.viewDidLoad()

        myView.isHidden = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //MARK: Calling retriving data function
       retriveData()
       
        //MARK: Calling nivagation bar image functions
        uiNavegationImage()
        
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        
       // self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @objc func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = locationManager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            userLocation = center
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            //            mapView.removeAnnotation(mapView!.annotations)
            let annoation = MKPointAnnotation()
            annoation.coordinate = center
            
//            annoation.title = "Your Location"
//            mapView.addAnnotation(annoation)
            //
            //            var annotion = MKPointAnnotation()
            //            annotion.coordinate = CLLocationCoordinate2D(latitude: 25.381929, longitude: 68.373039)
            //            mapView.addAnnotation(annotion)
            //            annotion.title = "Second Location"
            //            mapView.addAnnotation(annotion)
            locationManager.stopUpdatingLocation()
            
            dropMarker(mymodel: model)
            print("\(userLocation.latitude), \(userLocation.longitude)")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        
        activeSearch.start { (response, error) in
            if response == nil {
                print(error)
            }else {
                
                let searchAnnoation = MKPointAnnotation()
                self.mapView.removeAnnotation(searchAnnoation)
                let lat = response?.boundingRegion.center.latitude
                let long = response?.boundingRegion.center.longitude
                searchAnnoation.title = searchBar.text
                searchAnnoation.coordinate = CLLocationCoordinate2D(latitude: lat as! Double, longitude: long as! Double)
                self.mapView.addAnnotation(searchAnnoation)
                searchBar.resignFirstResponder()
                
            }
            
        }
    }
    
    func dropMarker(mymodel: [LocalModel]) {
//        for location in locations {
//            let annotations = MKPointAnnotation()
//            annotations.title = location["title"] as? String
//            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
//            mapView.addAnnotation(annotations)
//        }
        
        for var i in 0..<mymodel.count
        {
            let annotations = customAnnoation()
            annotations.title = (mymodel[i].title as? String)!
            annotations.coordinate = CLLocationCoordinate2D(latitude: mymodel[i].lat as! Double, longitude: mymodel[i].long as! Double)
            annotations.announcementImage = mymodel[i].announcementImage
            annotations.companyName = mymodel[i].companyName
            annotations.location = mymodel[i].location
            annotations.productImage = mymodel[i].productImage
            annotations.palceImages = mymodel[i].palceImages
            annotations.reviews = mymodel[i].reviews
            annotations.date = mymodel[i].date
            annotations.description1 = mymodel[i].description
            annotations.collaborattionTerms = mymodel[i].collaborattionTerms
            annotations.avalaibility = mymodel[i].avalaibility
            annotations.selectedNumOfFollowers = mymodel[i].selectedNumOfFollowers
            annotations.lat = mymodel[i].lat
            annotations.long = mymodel[i].long
            
            
            
            
            
            mapView.addAnnotation(annotations)
            
        }
    }
    
    

    //MARK: retrieving data from api
    
    func retriveData(){
        
        
        let announcementImage = "https://c1.staticflickr.com/5/4169/34275471846_37d07f53da_m.jpg"
        let title = "FAshion Announcement"
        let companyName = "Company Name"
        let location = "Dha Karachi"
        
        let localModel = LocalModel()
        
        localModel.announcementImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLp88Fq4O7S3Kke19q6XuYBMa9aS-unqEcxYlSNVRsO5Z2i7qH"
        localModel.title = "Fashion Announcement"
        localModel.companyName = "Initech"
        localModel.location = "Alberta, Canada"
        localModel.productImage = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLp88Fq4O7S3Kke19q6XuYBMa9aS-unqEcxYlSNVRsO5Z2i7qH","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLp88Fq4O7S3Kke19q6XuYBMa9aS-unqEcxYlSNVRsO5Z2i7qH","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLp88Fq4O7S3Kke19q6XuYBMa9aS-unqEcxYlSNVRsO5Z2i7qH"]
        localModel.palceImages = ["",""]
        localModel.reviews = ["",""]
        localModel.date = "27-August-2019"
        localModel.description = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        localModel.collaborattionTerms = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        localModel.avalaibility = ""
        localModel.selectedNumOfFollowers = "700"
        localModel.lat = 37.7975142
        localModel.long = -122.39902555
        

        let localModel1 = LocalModel()

        localModel1.announcementImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyHYzzGPOlsaXDC2ohdCpZINAHoCgPj25hYjeYr9MX7OwsjIuGUA"
        localModel1.title = "Food Announcement"
        localModel1.companyName = "Soylent Corp"
        localModel1.location = "Manitoba, Canada"
        localModel1.productImage = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyHYzzGPOlsaXDC2ohdCpZINAHoCgPj25hYjeYr9MX7OwsjIuGUA","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyHYzzGPOlsaXDC2ohdCpZINAHoCgPj25hYjeYr9MX7OwsjIuGUA","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyHYzzGPOlsaXDC2ohdCpZINAHoCgPj25hYjeYr9MX7OwsjIuGUA"]
        localModel1.palceImages = ["",""]
        localModel1.reviews = ["",""]
        localModel1.date = "9-September-2018"
        localModel1.description = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        localModel1.collaborattionTerms = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        localModel1.avalaibility = ""
        localModel1.selectedNumOfFollowers = "500"
        localModel1.lat = 24.87043195
        localModel1.long = 67.07135207586946

        let localModel2 = LocalModel()

        localModel2.announcementImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPl5QcJ6P-CYA9IL_YHwcdaUvKyKAmqbrOtjWTTj3A_8PId5Id"
        localModel2.title = "Beauty Announcement"
        localModel2.companyName = "Globex Corporation"
        localModel2.location = "Nunavut, Canada"
        localModel2.productImage = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPl5QcJ6P-CYA9IL_YHwcdaUvKyKAmqbrOtjWTTj3A_8PId5Id","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPl5QcJ6P-CYA9IL_YHwcdaUvKyKAmqbrOtjWTTj3A_8PId5Id","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPl5QcJ6P-CYA9IL_YHwcdaUvKyKAmqbrOtjWTTj3A_8PId5Id"]
        localModel2.palceImages = ["",""]
        localModel2.reviews = ["",""]
        localModel2.date = "19-December-2018"
        localModel2.description = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        localModel2.collaborattionTerms = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        localModel2.avalaibility = ""
        localModel2.selectedNumOfFollowers = "1000"
        localModel2.lat = 24.8710125
        localModel2.long = 67.0955209

        let localModel3 = LocalModel()

        localModel3.announcementImage = "https://c1.staticflickr.com/5/4169/34275471846_37d07f53da_m.jpg"
        localModel3.title = "Beauty Announcement"
        localModel3.companyName = "Acme Corporation"
        localModel3.location = "British Columbia"
        localModel3.productImage = ["https://c1.staticflickr.com/5/4169/34275471846_37d07f53da_m.jpg","https://c1.staticflickr.com/5/4169/34275471846_37d07f53da_m.jpg","https://c1.staticflickr.com/5/4169/34275471846_37d07f53da_m.jpg"]
        localModel3.palceImages = ["",""]
        localModel3.reviews = ["",""]
        localModel3.date = "1-October-2018"
        localModel3.description = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        localModel3.collaborattionTerms = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        localModel3.avalaibility = ""
        localModel3.selectedNumOfFollowers = "900"
        localModel3.lat = 24.86380975
        localModel3.long = 67.06757798545533


        self.model.append(localModel)
        self.model.append(localModel1)
        self.model.append(localModel2)
        self.model.append(localModel3)
        
    }
    
    // action:#selector(Class.MethodName) for swift 3
    
    @objc func action(){
        performSegue(withIdentifier: "sideMenu", sender: self)
    }
    
    
    @IBAction func collabrubBtnClicked(_ sender: UIButton) {
        
        let stroy = UIStoryboard(name: "Main", bundle: nil)
        let vc = stroy.instantiateViewController(withIdentifier: "pakage")
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        
    }
    
    //MARK: navigatio image setup
    
    func uiNavegationImage(){
        let logoImage:UIImage = UIImage(named: "logo_img")!
        self.navigationItem.titleView = UIImageView(image: logoImage)
    }
    

}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //performSegue(withIdentifier: "mapDetail", sender: self)
        //print(view.annotation?.title)
        
        myView.isHidden = false
        let anno = view.annotation as! customAnnoation
        imgCollabrub.sd_setImage(with: URL(string:(anno.announcementImage)))
        collabrubTitle.text = anno.title
        collabrubDescrip.text = anno.description1
        numOfFollowers.text = anno.selectedNumOfFollowers
        modelAnnoation = anno
       // btnCollabrub.addTarget(self, action: #selector(MapViewController.perFormEvent), for: .touchUpInside)
        
        
    }
    
    @objc func perFormEvent(){
        performSegue(withIdentifier: "mapDetail", sender: self)
        print(modelAnnoation.selectedNumOfFollowers)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapDetail" {
            let destinationVC = segue.destination as! LocalDetailsViewController
            destinationVC.modelCustom = modelAnnoation
        }
    }
    
}
