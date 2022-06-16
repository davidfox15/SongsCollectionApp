//
//  SongBarView.swift
//  SongApp
//
//  Created by Давид Лисицын on 16.06.2022.
//

import SwiftUI

struct SongBarView: View {
    @Binding var fontSize: Int
    @Binding var text : String
    var body: some View {
        ZStack {
            RoundCorner(cornerRadius: 35, maskedCorners: [.topLeft, .topRight])
                .frame(height: 90)
                .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.8941176470588236, green: 0.9137254901960784, blue: 0.9529411764705882)/*@END_MENU_TOKEN@*/)
            HStack {
                Spacer()
                Button(action: {
                  print("shared button")
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 50,height: 50)
                        .buttonStyle(.bordered)
                        .colorMultiply(.black)
                }
                Spacer()
                VStack {
                    Text("Text Size")
                    Stepper("",value: $fontSize, in: 13...30)
                        .padding(.all, 0)
                        .labelsHidden()
                }
                Spacer()
                VStack {
                    Text("Tone")
                    HStack{
                        Button {
                            // надо придумать как выбирать
                            // Picker в сплывающем окне
                            text = Tonality.up(text: text)
                            //song.tonality = Tonality.up(text: song.tonality)
                            print("Tonality Up")
                            
                        } label: {
                            Image(systemName: "chevron.up")
                                .foregroundColor(.black)
                        }
                        .padding(5)
                        
                        Button {
                            // надо придумать как выбирать
                            // Picker в сплывающем окне
                            text = Tonality.down(text: text)
                            //song.tonality = Tonality.down(text: song.tonality)
                            print("Tonality Down")
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                        }
                        .padding(5)
                    }
                }
                //                    if(!song.tonality.contains("#"))
                //                    {
                //                        Text("\(song.tonality)  ")
                //                    } else {
                //                        Text("\(song.tonality)")
                //                    }
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

//struct SongBarView_Previews: PreviewProvider {
//    @State static var fontSize: Int = 17
//    @State static var song = SongsService().getOne(id: 1)
//    static var previews: some View {
//        SongBarView(fontSize: $fontSize, song: $song)
//    }
//}
