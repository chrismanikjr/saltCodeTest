//
//  HomeViewModel.swift
//  SaltCodeTest
//
//  Created by Chrismanto Natanail Manik on 14/11/22.
//

import Foundation
class HomeViewModel: NSObject{
    let isValid = Box(false)
    private var networkManager = NetworkManager()
    
    
    let email = Box("")
    let fullName = Box("")
    let imgValue = Box("")
    let errorMessage = Box("")
    
    func fetchUser(){
        let pages = [["page": "1"], ["page": "2"]]
        guard let emailDefault = UserDefaults.standard.string(forKey: "Email") else {
            print("No Email")
            return
        }
        email.value = emailDefault
        for page in pages{
            networkManager.fetchData(with: ReqresAPI.fetchData, params: page) { [self] response, error in
                if let data = response?.data{
                    if !data.filter({self.email.value.contains($0.email)}).isEmpty{
                        let filterData = data.filter{self.email.value.contains($0.email)}
                        self.fullName.value = filterData[0].name
                        self.imgValue.value = filterData[0].avatar
                    }
                }else{
                    self.errorMessage.value = error?.rawValue ?? ""
                }
            }
        }
    }
}
