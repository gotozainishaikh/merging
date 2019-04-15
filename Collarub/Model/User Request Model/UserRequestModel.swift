//
//  UserRequestModel.swift
//  Collarub
//
//  Created by apple on 12/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserRequestModel{
    
    
    private var request_id:String!
    private var campaign_id:String!
    private var user_id:String!
    private var review:String!
    private var rate:String!
    private var urls:String!
    private var applied_on:String!
    private var partner_rate:String!
    private var partner_review:String!
    private var reqStatus:String!
    private var collaboration_id:String!
    private var collaboration_name:String!
    private var company_name:String!
    private var address:String!
    private var lat:String!
    private var longg:String!
    private var descriptions:String!
    private var date:String!
    private var followers_limit:String!
    private var expiry_date:String!
    private var collaborationType:String!
    private var partner_type:String!
    private var category_name:String!
    private var payment_id:String!
    private var engagement_rate:String!
    private var rating:String!
    private var number_of_post:String!
    private var status:String!
    private var partner_id:String!
    private var type:String!
    private var accep_budget_check:String!
    private var budget_value:String!
    private var discount_field:String!
    private var content_type:String!
    private var number_stories:String!
    private var number_post:String!
    private var required_city:String!
    private var required_region:String!
    private var min_user_rating:String!
    private var min_user_exp_level:String!
    private var user_gender:String!
    private var what_u_offer:String!
    private var wht_thy_hav_to_do:String!
    private var wht_wont_hav_to:String!
    private var e_mail:String!
    private var phone:String!
    private var payment_method:String!
    private var payment_conditions:String!
    private var ass_status:String!
    private var auto_approve:String!
    private var coupon_status:String!
    private var total_num_influencer:String!
    private var block_status:String!
    private var announcementImage : String = ""
    //private var productImage = [String]()
    var productImage = [String]()

    
    
    
    func set_request_data(json : JSON , json2 : JSON ){
      
       
        
         request_id = json["request_id"].stringValue
         campaign_id = json["campaign_id"].stringValue
         user_id = json["user_id"].stringValue
         review = json["review"].stringValue
         rate = json["rate"].stringValue
         urls = json["urls"].stringValue
         applied_on = json["applied_on"].stringValue
         partner_rate = json["partner_rate"].stringValue
         partner_review = json["partner_review"].stringValue
         reqStatus = json["reqStatus"].stringValue
         collaboration_id = json["collaboration_id"].stringValue
         collaboration_name = json["collaboration_name"].stringValue
         company_name = json["company_name"].stringValue
         address = json["address"].stringValue
         lat = json["lat"].stringValue
         longg = json["longg"].stringValue
         descriptions = json["descriptions"].stringValue
         date = json["date"].stringValue
         followers_limit = json["followers_limit"].stringValue
         expiry_date = json["expiry_date"].stringValue
         collaborationType = json["collaborationType"].stringValue
         partner_type = json["partner_type"].stringValue
         category_name = json["category_name"].stringValue
         payment_id = json["payment_id"].stringValue
         engagement_rate = json["engagement_rate"].stringValue
         rating = json["rating"].stringValue
         number_of_post = json["number_of_post"].stringValue
         status = json["status"].stringValue
         partner_id = json["partner_id"].stringValue
         type = json["type"].stringValue
         accep_budget_check = json["accep_budget_check"].stringValue
         budget_value = json["budget_value"].stringValue
         discount_field = json["discount_field"].stringValue
         content_type = json["content_type"].stringValue
         number_stories = json["number_stories"].stringValue
         number_post = json["number_post"].stringValue
         required_city = json["required_city"].stringValue
         required_region = json["required_region"].stringValue
         min_user_rating = json["min_user_rating"].stringValue
         min_user_exp_level = json["min_user_exp_level"].stringValue
         user_gender = json["user_gender"].stringValue
         what_u_offer = json["what_u_offer"].stringValue
         wht_thy_hav_to_do = json["wht_thy_hav_to_do"].stringValue
         wht_wont_hav_to = json["wht_wont_hav_to"].stringValue
         e_mail = json["e_mail"].stringValue
         phone = json["phone"].stringValue
         payment_method = json["payment_method"].stringValue
         payment_conditions = json["payment_conditions"].stringValue
         ass_status = json["ass_status"].stringValue
         auto_approve = json["auto_approve"].stringValue
         coupon_status = json["coupon_status"].stringValue
         total_num_influencer = json["total_num_influencer"].stringValue
         block_status = json["block_status"].stringValue
         announcementImage = json2[0]["img_url"].stringValue
         productImage = [json2[0]["img_url"].stringValue,json2[1]["img_url"].stringValue,json2[2]["img_url"].stringValue,json2[3]["img_url"].stringValue,json2[4]["img_url"].stringValue,json2[5]["img_url"].stringValue]
    }
    
    
    
    func get_request_id () -> String{
        
        return request_id
    }
    
    
    func get_applied_on() -> String{
        
        return applied_on
    }
    
  
    func get_descriptions() -> String{
        
        return descriptions
    }
    
    
    func get_collaboration_id() -> String{
        
        return collaboration_id
    }
  
    
    func get_partner_id() -> String{
        
        return partner_id
    }
    
    func get_collaboration_name() -> String{
        
        return collaboration_name
    }
    
    
    func get_required_city() -> String{
        
        return required_city
    }
    
    
    func get_required_region() -> String{
        
        return required_region
    }
    
    func get_expiry_date() -> String{
        
        return expiry_date
    }
    
    func get_date() -> String{
        
        return date
    }
    
    func get_type() -> String{
        
        return type
    }
    
    func get_budget_value() -> String{
        
        return budget_value
    }
    
    func get_discount_field() -> String{
        
        return discount_field
    }
    
    func get_content_type() -> String{
        
        return content_type
    }
    
    func get_engagement_rate() -> String{
        
        return engagement_rate
    }
    
    func get_rating() -> String{
        
        return rating
    }
    
    func get_user_gender() -> String{
        
        return user_gender
    }
    
    func get_min_user_exp_level() -> String{
        
        return min_user_exp_level
    }
    
    func get_announcementImage() -> String{
        
        return announcementImage
    }
    func get_productImage() -> [String]{
        
        return productImage
    }
    
    func get_productImagecount() -> [String]{
        
        return productImage
    }
//    cell.advertisementHeading.text = model[indexPath.row].title
//    cell.statusDescription.text = model[indexPath.row].description
//    cell.dateNum.text = String(model[indexPath.row].statusDay)
//    cell.monthName.text = model[indexPath.row].statusMonth
//
//
}
