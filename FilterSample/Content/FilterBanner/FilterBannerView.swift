//
//  FilterBannerView.swift
//  FilterSample
//
//  Created by cmStudent on 2022/06/28.
//

import SwiftUI

struct FilterBannerView: View {
    @State var selectedFilter: FilterType? = nil
    
    var body: some View {
        VStack{
            FilterTitleView(title: nil)
            FilterIconContainerView(
                selectedFIlter: $selectedFilter)
            FilterButtonContainerView()
        }
        
    }
}

struct FilterBannerView_Previews: PreviewProvider {
    static var previews: some View {
        FilterBannerView()
        
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
    
    @Binding var selectedFilter:FilterType?
    
    let uiImage: UIImage = UIImage(named:"image")!
    var body: some View{
        Button{
            selectedFilter = filterType
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

struct FilterIconContainerView: View{
    @Binding var selectedFIlter: FilterType?
    var body: some View{
        ScrollView(.horizontal,showsIndicators: false){
            //View
            HStack{
                //アイコンを並べる
                //モザイク
                FilterImage(filterType: .pixellate,
                            selectedFilter: $selectedFIlter)
                //セピア
                FilterImage(filterType: .sepiaTone ,
                            selectedFilter: $selectedFIlter)
                //シャープ
                FilterImage(filterType: .sharpenLuminance,
                            selectedFilter: $selectedFIlter)
                //モノクロ
                FilterImage(filterType: .photoEffectMono,
                            selectedFilter: $selectedFIlter)
                //ぼかし
                FilterImage(filterType: .gaussianBlur,
                            selectedFilter: $selectedFIlter)
                
            }
            .padding([.leading,.trailing],16)
        }
    }
}

struct FilterButtonContainerView: View{
    var body: some View{
        HStack{
            
            Button{
                //閉じる処理
                
            }label:{
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .padding()
            }
            Spacer()
            
            Button{
                //確定する処理
                
            }label:{
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .padding()
            }
        }
    }
}
