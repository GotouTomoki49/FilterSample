//
//  FilterBannerView.swift
//  FilterSample
//
//  Created by cmStudent on 2022/06/28.
//

import SwiftUI

struct FilterBannerView: View {
    var body: some View {
        Text("Hello,World")
    }
}

struct FilterBannerView_Previews: PreviewProvider {
    static var previews: some View {
        FilterImage(filterType: .gaussianBlur)
    }
}

struct FilterTitleView: View{
    let title: String?
    var body: some View{
        Text("\(title ?? "フィルターを選択")")
            .font(.title)
            .fontWeight(.bold)
            .padding(.top)
        
    }
}

struct FilterImage: View{
    //フィルターがかかった画像を作る
    @State private var image: Image?
    //何のフィルターか
    let filterType: FilterType
    
    let uiImage: UIImage = UIImage(named:"icon")!
    var body: some View{
        Button{
            //処理
        }label: {
            image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect()
        }
        .frame(width: 70, height: 70)
        .border(Color.white)
        .onAppear{
            //フィルターをかける
            if let outputImage =
                filterType.filter(inputImage: uiImage){
                self.image = Image(uiImage: outputImage)
            }
        }
        
    }
}
