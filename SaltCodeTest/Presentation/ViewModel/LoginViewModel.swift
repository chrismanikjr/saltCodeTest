//
//  LoginViewModel.swift
//  SaltCodeTest
//
//  Created by Chrismanto Natanail Manik on 13/11/22.
//

import Foundation
class LoginViewModel: NSObject{
    let isValid = Box(false)
    private var networkManager = NetworkManager()
    let showAlert = Box(false)
    let errorMessage = Box("")
    let toLogin = Box(false)
    
    private func checkEmail(_ text: String)-> Bool{
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        if emailTest.evaluate(with: text){
            return true
        }else{
            return false
        }
    }
    private func checkField(email: String, password: String){
        if email == "" || password == "" {
            self.errorMessage.value = "Please Fill your email and Password"
            showAlert.value = true
            print(errorMessage.value)
        }else{
            showAlert.value = !checkEmail(email)
        }
    }
    
    func login(_ email: String, password: String){
        checkField(email: email, password: password)
        if !showAlert.value{
            let params = ["email": email, "password": password]
            networkManager.requestLogin(with: ReqresAPI.login, body: params) { data, error in
                if data?.token != nil{
                    let defaults = UserDefaults.standard
                    defaults.set(email, forKey: "Email")
                    self.toLogin.value = true
                }else if data?.error != nil{
                    self.errorMessage.value = (data?.error)!
                    print("Errror: \(self.errorMessage.value)")
                }
                else{
                    self.errorMessage.value = error?.rawValue ?? ""
                    print("Errror: \(self.errorMessage.value)")
                }
            }
        }else{
            self.errorMessage.value = "Please Input correct email"
            print(self.errorMessage.value)
        }
    }
}

