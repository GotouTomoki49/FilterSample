//
//  ImagePicker.swift
//  FilterSample
//
//  Created by cmStudent on 2022/07/01.
//

import Foundation
import SwiftUI

//Representable
struct ImagePicker{
    //Viewとして使う
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    var sourceType:UIImagePickerController.SourceType
    
}

extension ImagePicker: UIViewControllerRepresentable{
    typealias UIViewControllerType = UIImagePickerController
    
    func makeUIViewController(context:
                              UIViewControllerRepresentableContext<ImagePicker>)->
    UIImagePickerController {
        //UIImagePickerControllerを作る
        //UIImagePickerControllerはclass(参照型)
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        
        //UIImagePickerControllerはDelegateがある
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: Context) {
        //なし
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
}

//Coordinator
final class Coordinator:NSObject,UINavigationControllerDelegate,
                        UIImagePickerControllerDelegate{
    //何をもってないといけない？→ImagePicker構造体
    let parent: ImagePicker
    
    init(parent: ImagePicker){
        self.parent = parent
        
    }
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo
                               info:[UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[.originalImage] as? UIImage else {return}
        parent.image = originalImage
        parent.isShown = false
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.isShown = false
    }
    
}

