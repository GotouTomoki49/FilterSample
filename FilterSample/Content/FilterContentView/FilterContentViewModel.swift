//
//  FilterContentViewModel.swift
//  FilterSample
//
//  Created by cmStudent on 2022/06/28.
//

import SwiftUI

class FilterContentViewModel: ObservableObject{
    enum Inputs{
        case onAppear
        
    }
    @Published var image: UIImage?
    @Published var isShowActionSheet = false
    
    func apply(_ inputs: Inputs){
        switch inputs{
        case.onAppear:
            //アクションシートを表示したい
            if image == nil{
            isShowActionSheet = true
           
            }
            
        }
    }
    
}
