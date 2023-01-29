
//  SwiftUIView.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2023. 01. 22..


import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        
        VStack{
            ZStack{
                Image(uiImage: #imageLiteral(resourceName: "a"))
                    .resizable()
                    .frame(width: 400, height: 600)
                    .clipShape(RoundedRectangle(cornerRadius: 39))
                    .frame(width: 301, height: 301).blur(radius: 5)
                
                VStack{
                    Button {
                        
                    } label: {
                        Image("Justine")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }.frame(maxWidth: .infinity,alignment: .leadingLastTextBaseline).padding().frame(width: 22)
                    
                    (Text("Hello").font(.system(size: 25))
                         +
                     Text(" Sara").font(.system(size: 25))
                    )
                    .font(.title2).frame(maxWidth: .infinity,alignment: .center)
                    
                    Spacer().frame(height: 400)
                }
                
               
            }
           
            
           
            
           // Spacer().frame(height: 120)
            
            
            
            //background(Color.red.blur(radius: 10))
            
        }
        
        //  Spacer()
        
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
