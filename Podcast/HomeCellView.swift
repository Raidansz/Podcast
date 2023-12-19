//
//  HomeCellView.swift
//  Podcast
//
//  Created by Raidan on 30/07/2024.
//"https://picsum.photos/200/300"

import SwiftUI
struct HomeCellView: View {
    var podcast: Feed?
    var image: String?
    var isStandAloneCell: Bool
    var body: some View {
        if isStandAloneCell {
         
                Button(action: {
                    let viewModel = EpisodeListViewModel(with: podcast?.url ?? "")
                    let view = EpisodeListView(viewModel: viewModel)
                }, label: {
                    AsyncImage(url: URL(string: image ?? "")) { image in
                        image
                        
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 331, height: 200)
                            .clipped()
                            .cornerRadius(8)
                            .padding()
                    } placeholder: {
                        ProgressView()
                    }
                })
            
        } else {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    AsyncImage(url: URL(string: image ?? "" )) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 108, height: 96)
                            .clipped()
                            .cornerRadius(8)
                            .padding()
                    } placeholder: {
                        ProgressView()
                    }
                   
                    VStack {
                        Text("See Mama Be")
                            .frame(alignment: .leading)
                        Text("Creative Studio")
                            .frame(alignment: .leading)
                        Text("15 min")
                            .frame(alignment: .leading)
                    }
                    Spacer()
                Image(uiImage: UIImage(systemName: "play.circle.fill")!)
                        .resizable()
                        .frame(width: 48, height: 48)
    //                    .padding(.trailing, 32)
                }
            })
        } 

    }
}

//#Preview {
//    HomeCellView(podcast: .in)
//}
