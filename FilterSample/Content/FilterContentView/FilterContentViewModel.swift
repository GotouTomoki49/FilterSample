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
    
    // フィルターバナー表示用フラグ
    @Published var isShowBanner = false
    
    // フィルターを適用するFilterType
    @Published var applyingFilter: FilterType? = nil
    
    // Combineを実行するためのCancellable
    var cancellables: [Cancellable] = []
    
    init() {
        // $を付けている→状態変数(Published→Publisher)
        let imageCancellable = $image.sink { [weak self] uiimage in
            guard let self = self, let uiimage = uiimage else { return }
            
            self.filterdImage = uiimage
        }
        //applyingFilterが更新
        let filterCancellable = $applyingFilter.sink{ [weak self]FilterType in
            guard let self = self,
                  let filterType = FilterType,
                  let image = self.image else{
                return
            }
            
            //画像を加工する
            guard let filterdUImage = self.updateImage(with: image, type: filterType) else {return}
            self.filterdImage = filterdUImage
        }
        
        cancellables.append(imageCancellable)
        cancellables.append(filterCancellable)
    }
    private func updateImage(with image:UIImage, type filter: FilterType) -> UIImage?{
        return filter.filter(inputImage: image)
    }
    
    func apply(_ inputs: Inputs) {
        switch inputs {
        case .onAppear:
            if image == nil {
                isShowActionSheet = true
            }
        case .tappedActionSheet(let sourceType):
            
            // フォトライブラリーを起動orカメラを起動
            selectedSourceType = sourceType
            isShowImagePickerView = true
        }
    }
}
