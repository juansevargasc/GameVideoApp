//
//  GameView.swift
//  GameStream
//
//  Created by Juanse Vargas on 12/10/21.
//

import SwiftUI
import AVKit

struct GameView: View
{
    var url: String
    var titulo: String
    var studio: String
    var calificacion: String
    var anoPublicacion: String
    var descripcion: String
    var tags: [String]
    var imgsUrl: [String]
    
    
    var body: some View
    {
        ZStack
        {
            Color("Marine").ignoresSafeArea()
            
            VStack
            {
                
                video(urlVideo: url).frame(height: 300)
                
                ScrollView
                {
                    // Información de video
                    videoInfo(titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion: descripcion, tags: tags)
                        .padding(.bottom)
                    
                    // Galería
                    Gallery(imgsUrl: imgsUrl)
                    
                    
                    // Comentarios
                    Comentarios()
                    
                    
                }.frame(maxWidth: .infinity)
                
            }
        }
    }
}

struct video: View
{
    var urlVideo: String
    var body: some View
    {
        VideoPlayer(player: AVPlayer(url: URL(string: urlVideo )! ) ).ignoresSafeArea()
        
    }
}

struct videoInfo: View
{
    var titulo: String
    var studio: String
    var calificacion: String
    var anoPublicacion: String
    var descripcion: String
    var tags: [String]
    
    var body: some View
    {
        
        VStack(alignment: .leading)
        {
            //Título
            Text("\(titulo)").foregroundColor(.white)
                .font(.largeTitle)
                .padding(.leading)
            
            // Estudio, calificación, año
            HStack
            {
                Text("\(studio)").foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5.0)
                    .padding(.leading)
                
                Text("\(calificacion)").foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5.0)
                    
                Text("\(anoPublicacion)").foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5.0)
                    
            }
            
            // Descripción
            Text("\(descripcion)").foregroundColor(.white)
                .font(.subheadline)
                .padding(.top, 5.0)
                .padding(.leading)
            
            HStack
            {
                ForEach(tags, id: \.self)
                {
                    tag in
                    
                    Text("#\(tag)").foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.top, 4.0)
                        .padding(.leading)
                    
                }
            }
            
            
            
        }.frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct Gallery: View
{
    var imgsUrl: [String]
    
    let formaGrid =
    [
        GridItem(.flexible())
    ]
    
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            Text("GALERÍA").foregroundColor(.white)
                .font(.largeTitle)
                .padding(.leading)
            
            
            ScrollView(.horizontal)
            {
                
                LazyHGrid(rows: formaGrid, spacing: 8)
                {
                    ForEach(imgsUrl, id: \.self)
                    {
                        imgu in
                        
                        //desplegar imagenes del servidor por medio de url
                        AsyncImage( url: URL( string: imgu )!  )
                        { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding()
                        } placeholder: {
                            placeholderImage()
                        }
                    }
                }
                
            }.frame(height: 180)
            
            
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    
}

struct Comentarios: View
{
    // Imagen de perfil
    // Nombre de usuario
    // Tiempo de publicación
    var body: some View
    {
        Text("COMENTARIO").foregroundColor(.white)
            .font(.largeTitle)
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ZStack
        {
            // Rectangle
            RoundedRectangle(cornerRadius: 8.0)
                .fill(Color("TabBar-Color"))
                .frame(width: 360)
            
            
            // Content
            VStack(alignment: .leading)
            {
                
                
                HStack
                {
                    // Foto
                    Image("perfilEjemplo").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .padding(.leading)
                    
                    VStack
                    {
                        // Nombre usuario
                        Text("User01").foregroundColor(.white).font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        // tiempo
                        Text("Hace 7 días").foregroundColor(.white).font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }.padding([.leading, .bottom])
                }
                
                // Texto de comentario
                Text("He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .frame(alignment: .leading)
                        .padding([.leading, .trailing, .top, .bottom], 10.0)
                
                
                
            }.frame(maxWidth: .infinity, alignment: .leading)
             .padding([.top, .leading, .bottom], 11.0)
        
        }
        
    }
}

@ViewBuilder
func placeholderImage() -> some View
{
    Image(systemName: "photo")
        .renderingMode(.template)
        .resizable()
        .aspectRatio(contentMode: .fit)

        .frame(width: 150, height: 150)
        .foregroundColor(.gray)
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        
        GameView(url: "ejemplo",titulo:"Sonic The Hedgehog"
            ,studio:"Sega"
            ,calificacion:"E+"
            ,anoPublicacion:"1991"
            ,descripcion:"Juego de Sega Genesis publicado en 1991 con más de 40 millones de copias vendidas actualmente"
            ,tags:["plataformas","mascota"], imgsUrl: [ "https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg"])

    }
}
