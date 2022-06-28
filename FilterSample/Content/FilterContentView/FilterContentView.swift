//
//  FilterContentView.swift
//  FilterSample
//
//  Created by cmStudent on 2022/06/28.
//

import SwiftUI

struct FilterContentView: View {
    @State private var filtedImage: UIImage?
    var body: some View {
        NavigationView{
            ZStack{
                if let filtedImage = filtedImage {
                    Image(uiImage: filtedImage)
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
    }
    
    var actionSheet: ActionSheet{
        var buttons: [ActionSheet.Button] = []
        
        if
            UIImagePickerController
                .isSourceTypeAvailable(.camera){
            //カメラが利用できるからカメラボタンを追加
            let cameraButton =
            ActionSheet.Button
                .default(Text("写真を撮る")){}
            buttons.append(cameraButton)
            
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //フォトライブラリーが使えるならばフォトライブラリーボタンを追加
            let photoLibraryButton =
            ActionSheet.Button.default(Text("アルバムから選択")) {}
            buttons.append(photoLibraryButton)
            
        }
        //キャンセルボタン
        let cancelButton = ActionSheet.Button.cancel(Text("キャンセル"))
        buttons.append(cancelButton)
    }
}

struct FilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilterContentView()
    }
}

