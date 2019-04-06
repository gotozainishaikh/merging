//
//  PageViewViewController.swift
//  Land
//
//  Created by Invision on 23/10/2017.
//  Copyright © 2017 Invision. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol PageViewControllerDelegate : class{
    
    func pageViewController(pageViewController: UIPageViewController,
                            didUpdatePageIndex index: Int)
    
}

class PageViewController: UIPageViewController {
    
    
    //MARK: Variables
    var currentPageIndex=0
    var viewControllerIdentifiers:[String] = []
    var direction:UIPageViewController.NavigationDirection!
    weak var pageDelegate: PageViewControllerDelegate?
    
    //Lazy closure to instantiate an array of viewcontrollers
    private(set) lazy var _viewControllers: [UIViewController] = {
       return makePages()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.delegate=self
        self.dataSource=self
        
        //self.moveToPage(index: currentPageIndex)
        self.moveToPage(index:0)
        
    }
    
    

    override func viewDidAppear(_ animated: Bool) {
        //self.moveToPage()
    }
    
    func makePages() -> [UIViewController]{
        
        var controllers:[UIViewController] = []
        
        for identifier in viewControllerIdentifiers{
            let controller = self.storyboard!.instantiateViewController(withIdentifier: identifier)
            controllers.append(controller)
        }
        
        return controllers
    }
    
    /**
     Scrolls the pageview controllet to the specified index
     - parameter index: The index of view controller to scroll to.
     */
    func moveToPage(index:Int){
        
        if index < _viewControllers.count{
            
            direction = index > currentPageIndex ? .forward : .reverse
            
            self.setViewControllers([_viewControllers[index]],
                                    direction: direction,
                                    animated: true,
                                    completion: nil)
            self.currentPageIndex = index
            
        }
        
//        if let firstViewController = _viewControllers.first {
//            setViewControllers([firstViewController],
//                               direction: .reverse,
//                               animated: true,
//                               completion: nil)
//
//            self.currentPageIndex = 0
//        }
        
    }
    var arr = [String]()
    var data = [String]()
    var imageData : [Data] = [Data]()
    var editId : String = ""
    var editData : JSON!
    
    func editingTable(){
        var stepData = StepViewController()
        
        print("all data :: \(editData)")
        var step1Data = Step1ViewController()
        //step1Data.categoryDropDown.selectedIndex = 0
        step1Data.category = editData[0]["category_name"].stringValue
        step1Data.online = editData[0]["collaborationType"].stringValue
        
        let reqDataDict = ["cat_name": step1Data.category,"type":step1Data.online]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reqreject"), object: nil, userInfo: reqDataDict)
       
    }
    

    func loadNotifier() {
        let reqDataDict = ["cat_name": "ass","type":"saa"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reqreject"), object: nil, userInfo: reqDataDict)
    }
    func done() {
        
        arr = []
        print("this is :: \(arr)")
        var step1Data = Step1ViewController()
        var step2Data = Step2ViewController()
        var step3Data = Step3ViewController()
        var step4Data = Step4ViewController()
        var step5Data = Step5ViewController()
        
        var step1 = self._viewControllers[0] as! Step1ViewController
        var step2 = self._viewControllers[1] as! Step2ViewController
        var step3 = self._viewControllers[2] as! Step3ViewController
        var step4 = self._viewControllers[3] as! Step4ViewController
        var step5 = self._viewControllers[4] as! Step5ViewController
        
        var type_col : String = ""
        // MARK  - Step1 Data
        if step1.local != "" {
            type_col = step1.local
        }else {
            type_col = step1.online
        }
        
        step1Data.category = step1.category
        
        print("\(type_col) \(step1Data.category)")
        
        
        // MARK  - Step2 Data
        step2Data.exchag = step2.exchag
        step2Data.discont = step2.discont
        step2Data.discountNmbr = step2.discountNmbr
        step2Data.maxBudgt = step2.maxBudgt
        step2Data.usingProd = step2.usingProd
        step2Data.locatin = step2.locatin
        step2Data.selfe = step2.selfe
        step2Data.shotTop = step2.shotTop
        step2Data.numStoris = step2.numStoris
        step2Data.numPost = step2.numPost
        step2Data.accptBugt = step2.accptBugt
        step2Data.startDate = step2.startDate
        step2Data.endDate = step2.endDate
        
        print("\(step2Data.exchag) :: \(step2Data.discont) :: \(step2Data.accptBugt) :: \(step2Data.discountNmbr) :: \(step2Data.maxBudgt) :: \(step2Data.usingProd) :: \(step2Data.locatin) :: \(step2Data.selfe) :: \(step2Data.shotTop) :: \(step2Data.numStoris) :: \(step2Data.numPost)")
        
        
        // MARK  - Step3 Data
        
        step3Data.engagementRt = step3.engagementRt
        step3Data.lCity = step3.lCity
        step3Data.lRegion = step3.lRegion
        step3Data.reputationLvl = step3.reputationLvl
        step3Data.exLevel = step3.exLevel
        step3Data.gndr = step3.gndr
        step3Data.follwrLimt = step3.follwrLimt
        
        print("\(step3Data.engagementRt) :: \(step3Data.follwrLimt) :: \(step3Data.lCity) :: \(step3Data.lRegion) :: \(step3Data.reputationLvl) :: \(step3Data.exLevel) :: \(step3Data.gndr) ")
        
        //MARK - Step4 Data
        
        step4Data.compyNam = step4.compyNam
        step4Data.addrss = step4.addrss
        step4Data.descrptin = step4.descrptin
        step4Data.whatoffring = step4.whatoffring
        step4Data.whatwillhv = step4.whatwillhv
        step4Data.whatWont = step4.whatWont
        step4Data.Primg1 = step4.Primg1
        step4Data.Primg2 = step4.Primg2
        step4Data.Primg3 = step4.Primg3
        step4Data.Loimg1 = step4.Loimg1
        step4Data.Loimg2 = step4.Loimg2
        step4Data.Loimg3 = step4.Loimg3
        step4Data.e_mail = step4.e_mail
        step4Data.telNo = step4.telNo
        step4Data.websit = step4.websit
        step4Data.lat = step4.lat
        step4Data.long = step4.long
        
        print("\(step4Data.compyNam) :: \(step4Data.addrss) :: \(step4Data.descrptin) :: \(step4Data.whatoffring) :: \(step4Data.whatwillhv) :: \(step4Data.whatWont) :: \(step4Data.Primg1) :: \(step4Data.Primg2) :: \(step4Data.Primg3) :: \(step4Data.Loimg1) :: \(step4Data.Loimg2) :: \(step4Data.Loimg3) :: \(step4Data.e_mail) :: \(step4Data.telNo) :: \(step4Data.websit) ")
        
        var pay_method :String = ""
        
        // MARK - Step5 Data
        step5Data.inLocl = step5.inLocl
        step5Data.inMcro = step5.inMcro
        step5Data.inMac = step5.inMac
        step5Data.inMga = step5.inMga
        step5Data.inStr = step5.inStr
//        step5Data.caLocl = step5.caLocl
//        step5Data.caMcro = step5.caMcro
//        step5Data.caMac = step5.caMac
//        step5Data.caMga = step5.caMga
//        step5Data.caStr = step5.caStr
        step5Data.payInflncer = step5.payInflncer
        step5Data.payCam = step5.payCam
        
        step5Data.pay_method = step5.pay_method
        
        
     
        print("\(step5Data.inLocl) :: \(step5Data.inMcro) :: \(step5Data.inMac) :: \(step5Data.inMga) :: \(step5Data.inStr) ::  \(step5Data.pay_method)")
        
        if(type_col == ""){
            arr.append("Select Campaign Type")
           // print("\(arr)")
        }
        if (step1Data.category == "") {
            arr.append("Select Category")
          //  print("\(arr)")
        }
        
        if (step2Data.exchag == "" && step2Data.discont == "") {
           arr.append("Select Collaboration type")
         //   print("\(arr)")
        }
        
        
        if (step2Data.discont != "") {
            if (step2Data.discountNmbr == nil) {
                arr.append("Enter discount percentage")
            }
        }
        
        if (step2Data.usingProd == "" && step2Data.locatin == "" && step2Data.selfe == "" && step2Data.shotTop == "") {
            arr.append("Select at least 1 content type")
           // print("\(arr)")
        }
        
        if (step3Data.engagementRt == "") {

            arr.append("Select Engagement Rate")
            //print("\(arr)")
        }
        
        
        if (step3Data.follwrLimt == "") {
            
            arr.append("Enter followers limit")
            //print("\(arr)")
        }
        
        if (step3Data.follwrLimt != "") {
            
            var vl : Int = Int(step3Data.follwrLimt)!
            
            if vl < 1000 {
            arr.append("Set minimum followers 1000")
            //print("\(arr)")
            }
        }
        
        
        if (step3Data.lCity == "" ) {
            arr.append("Select city")
            
           // print("\(arr)")
        }
        
        if (step3Data.lRegion == "") {
            arr.append("Select Region")
         //   print("\(arr)")
        }
        
        if (step3Data.reputationLvl == "") {
            arr.append("Enter Reputaion rating")
          //  print("\(arr)")
        }
        
        if (step3Data.reputationLvl != "") {
            
            var vl : Int = Int(step3Data.reputationLvl)!
            
            if vl > 5 {
                arr.append("Min Reputation rating is invalid")
                //print("\(arr)")
            }
        }
        
        
        if (step3Data.exLevel == "") {
            arr.append("Enter experience level")
          //  print("\(arr)")
        }
        
        if (step3Data.exLevel != "") {
            
            var vl : Int = Int(step3Data.exLevel)!
            
            if vl > 10 {
                arr.append("Min Experience level is invalid")
                //print("\(arr)")
            }
        }
        
        if (step3Data.gndr == "") {
            arr.append("Select gender")
          //  print("\(arr)")
        }
      
        if (step4Data.compyNam == "") {
            arr.append("Enter Compant Name")
           // print("\(arr)")
        }
        
        if (step4Data.addrss == "") {
            arr.append("Enter Address")
        }
        
        if (step4Data.descrptin == "") {
            arr.append("Enter Description")
        }
        
        if (step4Data.whatoffring == "") {
            arr.append("Enter What you offer")
        }
        
        if (step4Data.whatwillhv == "") {
            arr.append("Enter what they will have to do")
        }
        
        if (step4Data.whatWont == "") {
            arr.append("Enter what they will won't have to do")
        }
        
        if (step4Data.Primg1 == nil || step4Data.Primg2 == nil || step4Data.Primg3 == nil ) {
            arr.append("Select all 3 product images")
        }else if(step4Data.Primg1 != nil && step4Data.Primg2 != nil && step4Data.Primg3 != nil){
            
            imageData = [step4Data.Primg1!,step4Data.Primg2!,step4Data.Primg3!]
        }
        
        if (step4Data.Loimg1 == nil || step4Data.Loimg2 == nil || step4Data.Loimg3 == nil) {
            arr.append("Select all 3 location images")
        }else if(step4Data.Loimg1 != nil && step4Data.Loimg2 != nil && step4Data.Loimg3 != nil){
            imageData.append(step4Data.Loimg1!)
            imageData.append(step4Data.Loimg2!)
            imageData.append(step4Data.Loimg3!)
        }
        
        if (step4Data.e_mail == "") {
            arr.append("Enter email address")
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: step4Data.e_mail) == false {
            arr.append("Invlid Email Address")
        }
        
        if (step4Data.telNo == "") {
            arr.append("Enter telephone no")
        }
        
        if (step5Data.pay_method == "") {
            arr.append("Select Payment Method")
        }
        
        if (step5Data.pay_method != "") {

            if (step5Data.inLocl == "" && step5Data.inMcro == "" && step5Data.inMac == "" && step5Data.inMga == "" && step5Data.inStr == "") {
                arr.append("Select atleast 1 Reach method")
            }

        }
//        if (step5Data.payCam != "") {
//
//            if (step5Data.inLocl == "" && step5Data.inMcro == "" && step5Data.inMac == "" && step5Data.inMga == "" && step5Data.inStr == "") {
//                arr.append("Select atleast 1 Reach method")
//            }
//
//        }
        
        data = [type_col,step1Data.category,step2Data.exchag,step2Data.discont,step2Data.discountNmbr,step2Data.maxBudgt,step2Data.usingProd,step2Data.locatin,step2Data.selfe,step2Data.shotTop, step2Data.numStoris,step2Data.numPost,step2Data.accptBugt,step2Data.startDate,step2Data.endDate,step3Data.engagementRt,step3Data.lCity,step3Data.lRegion,step3Data.reputationLvl,step3Data.exLevel,step3Data.gndr, step3Data.follwrLimt,step4Data.compyNam,step4Data.addrss,step4Data.descrptin,step4Data.whatoffring,step4Data.whatwillhv,step4Data.whatWont,step4Data.e_mail,step4Data.telNo, step4Data.websit,step5Data.inLocl,step5Data.inMcro,step5Data.inMac,step5Data.inMga,step5Data.inStr,step5Data.pay_method,step4Data.lat,step4Data.long]
        
        
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = story.instantiateViewController(withIdentifier: "errorPop") as? ShowErrorPopViewController
        
        
        print("final :: \(arr)")
        
    }
    
}

//MARK: PageViewController methods
extension PageViewController: UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = _viewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let authenticationViewControllersCount = _viewControllers.count
        
        guard authenticationViewControllersCount != nextIndex else {
            return nil
        }
        
        guard authenticationViewControllersCount > nextIndex else {
            return nil
        }
        
        return _viewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = _viewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard _viewControllers.count > previousIndex else {
            return nil
        }
        
        return _viewControllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
       
        if let firstViewController = viewControllers?.first,
            let index = _viewControllers.index(of: firstViewController) {
            pageDelegate?.pageViewController(pageViewController: self, didUpdatePageIndex: index)
            self.currentPageIndex = index
        }
        
    }
    
}


