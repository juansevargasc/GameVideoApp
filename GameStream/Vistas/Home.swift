//
//  Home.swift
//  GameStream
//
//  Created by Juanse Vargas on 6/10/21.
//

import SwiftUI
import AVKit

struct Home: View
{
    @State var tabSeleccionado = 2
    
    init()
    {
        UITabBar.appearance().backgroundColor = UIColor(Color("TabBar-Color"))
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = true
    }
    
    var body: some View
    {
        
        TabView(selection: $tabSeleccionado)
        {
            
            ProfileView()
                .tabItem({
                    Image(systemName: "person")
                    Text("Perfil")
                }).tag(0) // Para referirnos a la pantalla de perfil será el tag 0
            
            GamesView()
                .tabItem({
                    Image(systemName: "gamecontroller").foregroundColor(.red)
                    Text("Juegos")
                }).tag(1)
            
            //Text("Pantalla Inicio").font(.system(size: 30, weight: .bold, design: .rounded))
            PantallaInicio()
                .tabItem({
                    Image(systemName: "house")
                    Text("Inicio")
                }).tag(2)
            
            FavoritesView()
                .tabItem({
                    Image(systemName: "heart")
                    Text("Favoritos")
                }).tag(3)
        }.accentColor(.white)
            
        
    }
    
    
}

struct PantallaInicio: View
{
    
    var body: some View
    {
        ZStack
        {
            Color("Marine").ignoresSafeArea()
            
            VStack
            {
                Image("appLogo").resizable().aspectRatio(contentMode: .fit).frame(width: 180)
                    .padding(.horizontal, 11.0)
                
                
                
                //Submódulo Home
                ScrollView(showsIndicators: false)
                {
                    SubModuloHome()
                                    
                }//.clipped()
                
            }.padding(.horizontal, 18)
            
            
            
        }.navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
        
        
    }
    
//    func busqueda()
//    {
//        print("el usuario está buscando \(textoBusqueda)")
//    }
}

struct SubModuloHome:View
{
    @State var isGameInfoEmpty = false
    @State var textoBusqueda = ""
    
    @ObservedObject var juegoEncontrado = SearchGame()
    @State var isGameViewActive = false
    
    @State var url: String = ""
    @State var titulo: String = ""
    @State var studio: String = ""
    @State var calificacion: String = ""
    @State var anoPublicacion: String = ""
    @State var descripcion: String = ""
    @State var tags: [String] = [""]
    @State var imgsUrl: [String] = [""]
    
    
    var body: some View
    {
        
        VStack
        {
            //Buscador
            HStack
            {
                Button(action: {
                    
                    watchGame(name: textoBusqueda)
                    
                    
                }, label:
                        {
                    
                    Image(systemName: "magnifyingglass").foregroundColor(textoBusqueda.isEmpty ? Color(.yellow) : Color("Dark-cian") )
                    
                }).alert(isPresented: $isGameInfoEmpty, content:
                    {
                        Alert(title: Text("Error"), message: Text("No se encontró el juego"), dismissButton: .default(Text("Entendido")))
                    }
                         )
                
                ZStack(alignment: .leading)
                {
                    if textoBusqueda.isEmpty
                    {
                        Text("Buscar un video").foregroundColor(Color(red: 174/255, green: 177/255, blue: 177/255, opacity: 1.0))
                    }
                    TextField("", text: $textoBusqueda).foregroundColor(.white)
                }
                
            }.padding([.top, .leading, .bottom], 11.0)
                .background(Color("TabBar-Color"))
                .clipShape( Capsule() )
            
            // Los más populares
            Text("Los más populares")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            ZStack
            {
                Button(action: {
                    /**/
                    watchGame(name: "The Witcher 3")
                }, label: {
                    
                    VStack(spacing: 0)
                    {
                        Image("thewitcher3").resizable().scaledToFit()
                        Text("The Witcher 3")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .background(Color("Light-Gray"))
                    }
                    
                })
                
                Image(systemName: "play.circle.fill").resizable()
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
                
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
            
            
            // Categorías sugeridas
            Text("CATEGORÍAS SUGERIDAS PARA TÍ")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top, 25)
            
            ScrollView(.horizontal, showsIndicators: false)
            {
                HStack
                {
                    Button(action: {}, label: {
                        
                        
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color("TabBar-Color"))
                                .frame(width: 160, height: 90)
                            
                            Image("Vector-shot").resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                        
                    })
                    
                    
                    Button(action: {}, label: {
                        
                        
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color("TabBar-Color"))
                                .frame(width: 160, height: 90)
                            
                            Image("rpg-icon").resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                        
                    })
                    
                    Button(action: {}, label: {
                        
                        
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color("TabBar-Color"))
                                .frame(width: 160, height: 90)
                            
                            Image("open-world-icon").resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                        
                    })
                    
                }
            }
            
            //Recomendados para tí
            Text("RECOMENDADOS PARA TÍ")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top, 25)
            ScrollView(.horizontal, showsIndicators: false)
            {
                HStack
                {
                    //
                    Button(action: {
                        watchGame(name: "Abzu")
                        
                    }, label: {
                        
                        
                            Image("abzu").resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                        
                        
                    })
                    
                    //
                    Button(action: {
                        watchGame(name: "Crash Bandicoot")
                        
                    }, label: {
                        
                        
                            Image("crashbandicoot").resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                        
                        
                    })
                    
                    //
                    Button(action: {
                        watchGame(name: "DEATH STRANDING")
                        
                    }, label: {
                        
                        
                            Image("deathstranding").resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                        
                        
                    })
                    
                    
                    
                }
            }
            
            
            //TODO: 1. Paadding para títulos , 2. Tercer carrusel
            //Videos que podrían gustarte
            Text("VIDEOS QUE PODRÍAN GUSTARTE")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top, 25)
            ScrollView(.horizontal, showsIndicators: false)
            {
                HStack
                {
                    //
                    Button(action: {
                        watchGame(name: "Cuphead")
                        
                    }, label: {
                        
                        
                            Image("cuphead").resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                        
                        
                    })
                    
                    //
                    Button(action: {
                        watchGame(name: "Hades")
                        
                    }, label: {
                        
                        
                            Image("hades").resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                        
                        
                    })
                    
                    //
                    Button(action: {
                            watchGame(name: "Grand Theft Auto V")
                        
                    }, label: {
                        
                        
                            Image("gtaV").resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 135)
                        
                        
                    })
                    
                    
                    
                }
            }
            
            
            
            
            
            
        }
        
        NavigationLink(destination: GameView(url: url, titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion: descripcion, tags: tags, imgsUrl: imgsUrl),
                       isActive: $isGameViewActive,
                       label: {
                            EmptyView()
                        })
        
        
    }
    
    func watchGame(name: String)
    {
        
        
        juegoEncontrado.search(gameName: name)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3)
        {
            
            print("Cantidad E: \(juegoEncontrado.gameInfo.count)")
            
            if juegoEncontrado.gameInfo.count == 0
            {
                isGameInfoEmpty = true
            }else
            {
                url = juegoEncontrado.gameInfo[0].videosUrls.mobile
                titulo = juegoEncontrado.gameInfo[0].title
                studio = juegoEncontrado.gameInfo[0].studio
                calificacion = juegoEncontrado.gameInfo[0].contentRaiting
                anoPublicacion = juegoEncontrado.gameInfo[0].publicationYear
                descripcion = juegoEncontrado.gameInfo[0].description
                tags = juegoEncontrado.gameInfo[0].tags
                imgsUrl = juegoEncontrado.gameInfo[0].galleryImages
                
                isGameViewActive = true
            }
            
        }
        
        print("Buscar \(name)")
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
        
    }
}


