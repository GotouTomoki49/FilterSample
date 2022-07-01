//
//  FilterContentView.swift
//  FilterSample
//
//  Created by cmStudent on 2022/06/28.
//

import SwiftUI

struct FilterContentView: View {
    @State private var filteredImage: UIImage?
    @StateObject private var viewModel = FilterContentViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                if let filteredImage = filteredImage {
                    Image(uiImage: filteredImage)
                } else{
                    EmptyView()
                }
                FilterBannerView()
            }
            //NavigatoinTitlleの設定
            .navigationTitle("ふぃるたー")
            //NavigationItem
            .navigationBarItems(trailing: HStack{
                Button {} label:{
                    Image(systemName:"square.and.arrow.down.fill" )
                }
                Button {} label:{
                    Image(systemName:"photo" )
                    
                }
            })
        }
        .onAppear{
            //画面表示の処理
            viewModel.apply(.onAppear)
        }
        .actionSheet(isPresented: $viewModel.isShowActionSheet){
            actionSheet
        }
        .sheet(isPresented: $viewModel.isShowImagePickerView){
            // ImagePicker
            ImagePicker(isShown:$viewModel.isShowImagePickerView,image: $viewModel.image,
                        sourceType: viewModel.selectedSourceType)
        }
        
    }
    var actionSheet: ActionSheet{
        var buttons: [ActionSheet.Button] = []
        
        if
            UIImagePickerController
                .isSourceTypeAvailable(.camera){
            //カメラが利用できるからカメラボタンを追加
            let cameraButton =
            ActionSheet.Button
                .default(Text("写真を撮る")){
                    viewModel.apply(.tappedActionSheet(selectType: .camera))
                }
            buttons.append(cameraButton)
            
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //フォトライブラリーが使えるならばフォトライブラリーボタンを追加
            let photoLibraryButton =
            ActionSheet.Button.default(Text("アルバムから選択")) {
                viewModel.apply(.tappedActionSheet(selectType: .photoLibrary))
            }
            buttons.append(photoLibraryButton)
            
        }
        //キャンセルボタン
        let cancelButton = ActionSheet.Button.cancel(Text("キャンセル"))
        buttons.append(cancelButton)
        
        let actionSheet = ActionSheet(title: Text("画像の選択"),
                                      message: nil, buttons: buttons)
        
        return actionSheet
    }
    
}


struct FilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilterContentView()
    }
}

