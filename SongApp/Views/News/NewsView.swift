//
//  NewsVIew.swift
//  SongApp
//
//  Created by Давид Лисицын on 19.06.2022.
//

import SwiftUI

struct NewsView: View {
    // Смена страницы
    @Binding var page: Int
    
    @State var str: String = ""
    
    var body: some View {
        VStack{
            
            TextField("Hello", text: $str)
            Spacer()
            NavigationBarView(page: $page)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct NewsView_Previews: PreviewProvider {
    @State static var page: Int = 1
    
    static var previews: some View {
        NewsView(page: $page)
    }
}
