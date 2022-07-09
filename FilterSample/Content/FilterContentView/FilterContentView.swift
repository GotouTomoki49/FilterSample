//
//  FilterContentView.swift
//  FilterSample
//
//  Created by cmStudent on 2022/06/28.
//
import SwiftUI

struct FilterContentView: View {
    
    @StateObject private var viewModel = FilterContentViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if let filterdImage = viewModel.filterdImage {
                    Image(uiImage: filterdImage)
                        .onTapGesture {
                            withAnimation {
                                viewModel.isShowBanner.toggle()
                            }
                        }
                } else {
                    EmptyView()
                }
                FilterBannerView()
            }
            .navigationTitle("ふぃるたー")
            .navigationBarItems(trailing: HStack {
                Button {} label: {
                    Image(systemName: "square.and.arrow.down")
                }
                Button {} label: {
                    Image(systemName: "photo")
                }
            })
            .onAppear{
                viewModel.apply(.onAppear)
            }
            .actionSheet(isPresented: $viewModel.isShowActionSheet) {
                actionSheet
            }
            .sheet(isPresented: $viewModel.isShowImagePickerView) {
                ImagePicker(isShown: $viewModel.isShowImagePickerView, image: $viewModel.image, sourceType: viewModel.selectedSourceType)
            }
        }
    }
    
    var actionSheet: ActionSheet {
        var buttons: [ActionSheet.Button] = []
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // カメラボタン
            let cameraButton = ActionSheet.Button.default(Text("写真を撮る")){
                viewModel.apply(.tappedActionSheet(selectType: .camera))
            }
            buttons.append(cameraButton)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // フォトライブラリー
            let photoLibraryButton = ActionSheet.Button.default(Text("アルバムから選択")) {
                viewModel.apply(.tappedActionSheet(selectType: .photoLibrary))
            }
            buttons.append(photoLibraryButton)
        }
        // キャンセルボタン
        let cancelButton = ActionSheet.Button.cancel(Text("キャンセル"))
        buttons.append(cancelButton)
        
        let actionSheet = ActionSheet(title: Text("画像選択"), message: nil, buttons: buttons)
        
        return actionSheet
        
    }
}

struct FilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilterContentView()
    }
}
