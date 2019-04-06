import Foundation


struct Defaults{
    
    static let userDefaults = UserDefaults.standard
    
    
    static var isLogedIn :Bool {
        if let lang = Defaults.userDefaults.value(forKey: "isLogIn") as? Bool{
            return lang
        }
        return false
    }
    
    static var isPartnerLogedIn :Bool {
        if let lang = Defaults.userDefaults.value(forKey: "isPartnerLogIn") as? Bool{
            return lang
        }
        return false
    }
    
    
    
    static func setLoginStatus(logInStatus:Bool){
        userDefaults.set(logInStatus, forKey: "isLogIn")
        userDefaults.synchronize()
    }
    
    static func setPartnerLoginStatus(logInStatus:Bool){
        userDefaults.set(logInStatus, forKey: "isPartnerLogIn")
        userDefaults.synchronize()
    }
    
    
}
