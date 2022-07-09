//
//  FilterContentViewModel.swift
//  FilterSample
//
//  Created by cmStudent on 2022/06/28.
//

import SwiftUI
import Combine

final class FilterContentViewModel: ObservableObject {
    enum Inputs {
        case onAppear
        case tappedActionSheet(selectType: UIImagePickerController.SourceType)
    }
    @Published var image: UIImage?
    @Published var filterdImage: UIImage?
    
    @Published var isShowActionSheet = false
    @Published var isShowImagePickerView = false
    
    @Published var selectedSourceType: UIImagePickerController.SourceType = .camera
    // フィルターバナー
    @Published var isShowBanner = false
    
    // Combineを実行するためのCancellable
    var cancellables: [Cancellable] = []
    
    init() {
        // $を付けている　Published→Publisher
        let imageCancellable = $image.sink { [weak self] uiimage in
            guard let self = self, let uiimage = uiimage else { return }
            
            self.filterdImage = uiimage
        }
        
        cancellables.append(imageCancellable)
    }
    
    func apply(_ inputs: Inputs) {
        switch inputs {
        case .onAppear:
            if image == nil {
                isShowActionSheet = true
            }
        case .tappedActionSheet(let sourceType):
            // フォトライブラリーを起動
            selectedSourceType = sourceType
            isShowImagePickerView = true
        }
    }
}
