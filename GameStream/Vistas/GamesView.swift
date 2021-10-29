//
//  GamesView.swift
//  GameStream
//
//  Created by Juanse Vargas on 11/10/21.
//

import SwiftUI

struct GamesView:View
{
    
    @ObservedObject var todosLosVideojuegos = ViewModel() // Property Wrapper: Observed Object,
    
    @State var gameviewIsActive: Bool = false
    @State var url: String = ""
    @State var titulo: String = ""
    @State var studio: String = ""
    @State var calificacion: String = ""
    @State var anoPublicacion: String = ""
    @State var descripcion: String = ""
    @State var tags: [String] = [""]
    @State var imgsUrl: [String] = [""]
    
    let formaGrid =
    [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @ViewBuilder
    func placeholderImage() -> some View {
        Image(systemName: "photo")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
    
            .frame(width: 150, height: 150)
            .foregroundColor(.gray)
    }
    
    var body: some View
    {
        
        
        ZStack
        {
            
            Color("Marine").ignoresSafeArea()
            
            VStack
            {
                
                Text("JUEGOS").font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                
                
                ScrollView
                {
                    LazyVGrid(columns: formaGrid, spacing: 8)
                    {
                        ForEach(todosLosVideojuegos.gamesInfo, id: \.self)
                        {
                            juego in
                            
                            Button(action: {
                                
                                url = juego.videosUrls.mobile
                                titulo = juego.title
                                studio = juego.studio
                                calificacion = juego.contentRaiting
                                anoPublicacion = juego.publicationYear
                                descripcion = juego.description
                                tags = juego.tags
                                imgsUrl = juego.galleryImages
                                
                                print("Pulse el juego \(titulo)")
                                
                                // Para indicar que se pulsó un juego y se entro a la pantalla de este juego
                                gameviewIsActive = true
                                
                            }, label: {
                                
                                // Imagen y título de cada juego.
                                VStack
                                {
                                    AsyncImage( url: URL( string: juego.galleryImages[0] )!  )
                                    { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .padding()
                                    } placeholder: {
                                        placeholderImage()
                                    }
                                        
                                        
                                    Text("\(juego.title)").foregroundColor(.white)
                                        .font(.body)
                                        .padding(.bottom, 12.0)
                                    
                                }
                                
                                
                            }
                                
                                   )
                        }
                     }
                }
                
            }.padding(.horizontal, 6.0)
            
            
            NavigationLink(destination: GameView(url: url, titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion: descripcion, tags: tags, imgsUrl: imgsUrl),
                           isActive: $gameviewIsActive,
                           label: {
                                EmptyView()
            })
            
            
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
            .onAppear(
                
                perform:
                {
                    
                    //Muestra la información del primer elemento del json
                    print("Primer elemento del json: \(todosLosVideojuegos.gamesInfo[0])")
                    print("Titulo del primer elemento del json: \(todosLosVideojuegos.gamesInfo[0].title)")
                })
        
    }
}
