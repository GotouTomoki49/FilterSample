//
//  FilterContentViewModel.swift
//  FilterSample
//
//  Created by cmStudent on 2022/06/28.
//

import SwiftUI
import Combine

final class FilterContentViewModel: NSObject, ObservableObject {
    enum Inputs {
        case onAppear
        case tappedActionSheet(selectType: UIImagePickerController.SourceType)
        case tappedSaveIcon
    }
    
    @Published var image: UIImage?
    @Published var filterdImage: UIImage?
    
    @Published var isShowActionSheet = false
    @Published var isShowImagePickerView = false
    
    @Published var selectedSourceType: UIImagePickerController.SourceType = .camera
    
    // フィルターバナー表示のフラッグ
    @Published var isShowBanner = false
    
    // フィルターを適用するFilterType
    @Published var applyingFilter: FilterType? = nil
    
    // Combineを実行するためのcancellable
    var cancellables: [Cancellable] = []
    
    var alertTitle: String = ""
    // アラートwp表示するためのフラグ
    @Published var isShowAlert = false
    
    override init() {
        super.init()
        // $を付けている（状態変数として使う→今回はPublished→Publisher）
        let imageCancellable = $image.sink { [weak self] uiimage in
            guard let self = self , let uiimage = uiimage else { return }
            
            self.filterdImage = uiimage
        }
        
        // applyingFilterが更新されたら
        
        let filterCancellable = $applyingFilter.sink { [weak self] filterType in
            guard let self = self,
                  let filterType = filterType,
                  let image = self.image else {
                return
            }
            
            
            // 画像加工
            guard let filterdUIImage = self.updateImage(with: image, type: filterType) else { return }
            self.filterdImage = filterdUIImage
            //cancellables.append(filterCancellable)
            
        }
        
        cancellables.append(imageCancellable)
        cancellables.append(filterCancellable)
    }
    
    // うまくいくか分からないのでオプショナルにする　＝　？をつける
    private func updateImage(with image: UIImage, type filter: FilterType) -> UIImage? {
        return filter.filter(inputImage: image)
    }
    
    
    func apply(_ inputs: Inputs) {
        switch inputs {
        case .onAppear:
            if image == nil {
                // アクションシートを表示したい
                isShowActionSheet = true
            }
        case .tappedActionSheet(let sourceType):
            // フォトライブラリーを起動する（あるいはカメラを起動する？）
            selectedSourceType = sourceType
            isShowImagePickerView = true
        case .tappedSaveIcon:
            // 画像を保存する処理
            UIImageWriteToSavedPhotosAlbum(filterdImage!, self, #selector(imageSaveCompletion(_:didFinishSaveingWithError:contextInfo:)), nil)
            //break
        case .tappedActionSheet:
            isShowActionSheet = true
            
        }
    }
    @objc func imageSaveCompletion(_ image: UIImage, didFinishSaveingWithError error: Error? ,
                                   contextInfo: UnsafeRawPointer) {
        alertTitle = error == nil ? "画像が保存されました" : error?.localizedDescription ?? ""
        isShowAlert = true
    }
}
