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
        case tappedActionSheet(selectType:UIImagePickerController.SourceType)
        
        
    }
    @Published var image: UIImage?
    @Published var isShowActionSheet = false
    @Published var isShowImagePickerView = false
    
    @Published  var selectedSourceType: UIImagePickerController.SourceType = .camera
    
    func apply(_ inputs: Inputs){
        switch inputs{
        case.onAppear:
            //アクションシートを表示したい
            if image == nil{
                isShowActionSheet = true
                
            }
            
        case .tappedActionSheet(selectType: let sourceType):
            //フォトライブラリーを起動、あるいはカメラを起動
            selectedSourceType = sourceType
            isShowImagePickerView = true
            
        }
    }
    
}
