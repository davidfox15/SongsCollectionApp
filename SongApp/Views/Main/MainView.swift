//
//  MainView.swift
//  SongApp
//
//  Created by Давид Лисицын on 08.06.2022.
//

import SwiftUI

struct MainView: View {
    @State var page: Int = 2
    //Загрузка с сервера
    @ObservedObject var songsViewModelFromServer: SongsService = SongsService(.all)
    @ObservedObject var filter: Filter = Filter()
    
    var body: some View {
        switch(page) {
       // case 1:
            //NewsView(page: $page)
        case 2:
            CatalogView(page: $page, songsViewModel: songsViewModelFromServer, filter: filter)
        //case 3:
            //PlayListsView(page: $page)
        default:
            Text("Page does not exist")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
