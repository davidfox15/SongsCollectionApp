//
//  NavigationBarView.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//

import SwiftUI

struct NavigationBarView: View {
    //MARK: - Change Page
    @Binding var page: Int
    
    var body: some View {
        ZStack{
            RoundCorner(cornerRadius: 35, maskedCorners: [.topLeft, .topRight])
                .frame(height: 90)
                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.8941176470588236, green: 0.9137254901960784, blue: 0.9529411764705882)/*@END_MENU_TOKEN@*/)
            HStack{
                Spacer()
                if page == 1{
                    Image(systemName: "newspaper")
                        .foregroundColor(.black)
                        .frame(width: 50,height: 50)
                        
                } else {
                    Image(systemName: "newspaper")
                        .foregroundColor(.gray)
                        .frame(width: 50,height: 50)
                        .onTapGesture {
                            page = 1
                        }
                        
                }
                Spacer()
                if page == 2 {
                    Image(systemName: "music.note.list")
                        .foregroundColor(.black)
                        .frame(width: 50,height: 50)
                } else {
                    Image(systemName: "music.note.list")
                        .foregroundColor(.gray)
                        .frame(width: 50,height: 50)
                        .onTapGesture {
                            page = 2
                        }
                }
                Spacer()
                if page == 3 {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.black)
                        .frame(width: 50,height: 50)
                } else {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.gray)
                        .frame(width: 50,height: 50)
                        .onTapGesture {
                            page = 3
                        }
                }
                Spacer()
            }
        }
    }
    
    struct RoundCorner: Shape {
        
        // MARK: - PROPERTIES
        
        var cornerRadius: CGFloat
        var maskedCorners: UIRectCorner
        
        
        // MARK: - PATH
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: maskedCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            return Path(path.cgPath)
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    
    @State static var page: Int = 2
    
    static var previews: some View {
        NavigationBarView(page: $page)
    }
}
