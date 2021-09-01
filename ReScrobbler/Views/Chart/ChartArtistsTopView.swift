//
//  ArtistsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI



func getData() -> getTopArtists.jsonStruct?{
    /**
        Getting data from URL (online) or from defaults (offline)
     */
    if let savedJson = defaults.object(forKey: "SavedArtistsTop") as? Data {
        if let loadedJson = try? JSONDecoder().decode(getTopArtists.jsonStruct.self, from: savedJson) {
            print("[LOG]:> {ArtistsTopView} Loaded local JSON struct from <defaults>.")
            return loadedJson
        }
    }
    else{
        if let jsonFromInternet = try? JSONDecoder().decode(getTopArtists.jsonStruct.self, from:getJSONFromUrl("method=chart.gettopartists&limit=100")){
            print("[LOG]:> {ArtistsTopView} Loaded JSON struct from <internet>")
            if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
                defaults.set(encoded, forKey: "SavedArtistsTop")
            }
            return jsonFromInternet
        }
        else{
            print("[LOG]:> An error has occured while getting data from Internet.")
        }
    }
    return nil
}



func getArtistInfo(artistName: String) -> getInfoArtist.jsonStruct?{
    if let jsonFromInternet = try? JSONDecoder().decode(getInfoArtist.jsonStruct.self, from:getJSONFromUrl("method=artist.getinfo&artist=" + artistName.urlEncoded!)){
        print("[LOG]:> {ArtistInfoPopUpView} Loaded JSON struct from <internet>")
        
        return jsonFromInternet
    }
    else{
        print("[LOG]:> An error has occured while getting data from Internet.")
    }
    return nil
}

struct ArtistInfoPopUpView: View {
    var artistName : String = "Unknown Artist"
    var isOnTour : Bool = false
    var tags : [String?] = []
    var listeners : String = "Unknown"
    var playCount : String = "Unknown"
    var aboutArtist : String?
    var similarArtists : [String?] = []
    
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(){
                HStack{
                    
                    ZStack{
                        Text(artistName)
                            .font(.system(size: 30))
                            .fontWeight(.light)
                            .lineLimit(1)
                            .padding([.top, .leading, .trailing], 25.0)
                        if isOnTour{
                            HStack{
                                Spacer()
                                VStack{
                                    ColoredRoundedButton(title: "On Tour", action: {}, color: Color.purple)
                                }
                            }
                        }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(tags, id: \.self){ tag in
                            ColoredRoundedButton(title: tag ?? "Unknown Tag", action: {}, color: Color.random)
                        }
                    }
                }.clipShape(Capsule())
                
                HStack{
                    Group{
                        Text("Listeners: " + (listeners.roundedWithAbbreviations))
                        Text("Play Count: " + (playCount.roundedWithAbbreviations))
                    }
                    .padding(.horizontal)
                    .font(.system(size: 15))
                    .opacity(0.8)
                }
                Group{
                    if aboutArtist != nil{
                        VStack(alignment: .leading){
                            Text("About artist:")
                                .font(.system(size: 20))
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            
                            Text(aboutArtist?.withoutHtmlTags ?? "No information provided")
                                .font(.system(size: 15))
                                .fontWeight(.light)
                                .fixedSize(horizontal: false, vertical: true)
                            
                        }.padding(.top, 10)
                    }
                    if similarArtists != []{
                        VStack(alignment: .leading){
                            Text("Similar artists:")
                                .font(.system(size: 20))
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            VStack(spacing: 5.0){
                                ForEach(0..<similarArtists.count){ index in
                                    SimilarArtistButton(artistName: similarArtists[index] ?? "Unknown Artist", index: index+1, action: {})
                                }
                            }
                            
                        }.padding(.top, 10)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
            }
            
            
        }
        .padding(.horizontal, 22.0)
        .frame(maxWidth: 800, maxHeight: 600)
        .background(Color(NSColor.windowBackgroundColor))
        .cornerRadius(20)
        
    }
}

struct ChartArtistsTopView: View {
    @State var showAlert = false
    @State var chosenArtistName : String = ""
    var body: some View {
        ZStack{
            if showAlert{
                let artistInfo = getArtistInfo(artistName: chosenArtistName)?.artist
                let tagsFormatted : [String?] = {
                    var arr : [String] = []
                    for tag in artistInfo?.tags?.tag ?? []{
                        arr.append(tag.name ?? "")
                    }
                    return arr
                }()
                
                let similarArtistsFormatted : [String?] = {
                    var arr : [String] = []
                    for artist in artistInfo?.similar?.artist ?? []{
                        arr.append(artist.name ?? "")
                    }
                    return arr
                }()
                
                ArtistInfoPopUpView(
                    artistName: artistInfo?.name ?? "",
                    isOnTour: (artistInfo?.ontour == "1" ? true : false),
                    tags: tagsFormatted,
                    listeners: artistInfo?.stats?.listeners ?? "",
                    playCount: artistInfo?.stats?.playcount ?? "",
                    aboutArtist: artistInfo?.bio?.summary ?? "",
                    similarArtists: similarArtistsFormatted)
                    
                    .zIndex(2)
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                    
                    .background(Color.gray.opacity(0.5))
                    .onTapGesture {
                        withAnimation{
                            showAlert = false
                        }
                    }
            }
            
            ScrollView(.vertical){
                VStack{
                    
                    if let json = getData(){
                        if let jsonSimplified = json.artists?.artist{
                            
                            let vGridLayout = [
                                GridItem(.flexible(maximum: 80), spacing: 0),
                                GridItem(.flexible(), spacing: 0),
                                GridItem(.flexible(), spacing: 0),
                                GridItem(.flexible(), spacing: 0)
                            ]
                            
                            
                            LazyVGrid(columns: vGridLayout, spacing: 0) {
                                ForEach(0 ..< (jsonSimplified.count)) { value in
                                    let currentColor : Color = {
                                        if (value+1).isMultiple(of: 2){
                                            return Color.gray.opacity(0.1)
                                        } else {
                                            return Color.gray.opacity(0.00001)
                                        }
                                    }()
                                    
                                    Group{
                                        Rectangle()
                                            .foregroundColor(currentColor)
                                            .frame(height: 50)
                                            .overlay(
                                                Text("\(value+1)")
                                                    .font(.title2)
                                            )
                                        
                                        Rectangle()
                                            .foregroundColor(currentColor)
                                            .frame(height: 50)
                                            .overlay(
                                                Text(jsonSimplified[value].name ?? "Unknown Tag")
                                                    .bold()
                                            )
                                        
                                        Rectangle()
                                            .foregroundColor(currentColor)
                                            .frame(height: 50)
                                            .overlay(
                                                Text("Listeners: \(jsonSimplified[value].listeners?.roundedWithAbbreviations ?? "Unknown")")
                                            )
                                        
                                        Rectangle()
                                            .foregroundColor(currentColor)
                                            .frame(height: 50)
                                            .overlay(
                                                Text("Play Count: \(jsonSimplified[value].playcount?.roundedWithAbbreviations ?? "Unknown")")
                                            )
                                        
                                    }
                                    
                                    .onTapGesture{
                                        if let artistName = jsonSimplified[value].name{
                                            chosenArtistName = artistName
                                            withAnimation{
                                                showAlert = true
                                            }
                                        }
                                        
                                    }
                                }
                                
                                
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                
            }
        }.zIndex(1)
    }
}



struct ArtistsTopEntry: View {
    var index: Int
    var artist: String
    var listenersCount: String
    var playCount: String
    
    var body: some View {
        VStack(){
            Divider()
            HStack{
                Text(String(index))
                    .font(.title2)
                    .padding()
                    .frame(width: 80)
                Group{
                    Text(artist).bold()
                        .frame(width: 200, alignment: .leading)
                    Text("Listeners: " + listenersCount)
                        .frame(width: 200, alignment: .leading)
                    Text("Play Count: " + playCount)
                        .frame(width: 200, alignment: .leading)
                }.padding()
            }.lineLimit(1)
            Divider()
        }
    }
    
}


struct TruePreview: View {
    var body: some View {
        
        VStack{
        HStack(){
            Image("Allie-X")
                .frame(width: 200, height: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.3), lineWidth: 5).blur(radius: 0.5)
                )
                .cornerRadius(20)
                .padding()
            
            VStack(alignment: .leading){
                Group(){
                    Text("Allie X")
                        .frame(minWidth: 200, alignment: .leading)
                        .font(.title2)
                        .padding()
                    
                    
                    
                    Text("Cape God")
                        .fontWeight(.bold)
                        .frame(minWidth: 300, alignment: .leading)
                        .font(.largeTitle)
                        .padding()
   
                }
                .foregroundColor(Color.white)
                .background(Color.white.opacity(0.5))
                
                .opacity(0.8)
                
                .cornerRadius(20)
                
            }
        }
        .frame(width: 700, alignment: .leading)
        .background(
            ZStack{
                Image("Allie-X")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 4.0, opaque: true)
                Color.black.opacity(0.2)
            }
        )
        
        .cornerRadius(25)
        /////////
        HStack(){
            Image("Tessa-Violet")
                .frame(width: 200, height: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black.opacity(0.3), lineWidth: 5).blur(radius: 0.5)
                )
                .cornerRadius(20)
                .padding()
            
            VStack(alignment: .leading){
                Group(){
                    Text("Tessa Violet")
                        .frame(minWidth: 200, alignment: .leading)
                        .font(.title2)
                        .padding()
                        
                    
                    Text("Bad Ideas")
                        .fontWeight(.bold)
                        .frame(minWidth: 300, alignment: .leading)
                        .font(.largeTitle)
                        .padding()
                        
                }
                .foregroundColor(Color.white)
                .background(Color.black.opacity(0.5))
                
                .opacity(0.8)
                
                .cornerRadius(20)
                
            }
        }
        .frame(width: 700, alignment: .leading)
        .background(
            ZStack{
                Image("Tessa-Violet")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 4.0, opaque: true)
                    //.padding(-20)
                Color.black.opacity(0.2)
            }
        )
        
        .cornerRadius(25)
        
        
        
    }
    }
}

struct ArtistsTioView_Previews: PreviewProvider {
    
    static var previews: some View {
        TruePreview()
        
        /*ArtistInfoPopUpView(artistName: "Marina and the Diamonds",
         isOnTour: true,
         tags: ["Pop", "Rock", "Female", "This is very long", "Test", "Bar", "Baz", "Boom"],
         listeners: "1234567",
         playCount: "98765432",
         aboutArtist: "Melanie Adele Martinez, known professionally as Melanie Martinez is an American singer, songwriter, artist, film director, music video director, actress, dancer and photographer. Moriah Rose Pereira known professionally as Poppy (or Moriah Poppy, That Poppy), is an American singer, songwriter, actress and model. In early 2014, Poppy signed to Island Records. Over a year later, her debut single ''Everybody Wants to Be Poppy'' was released and in early 2016, she released her debut extended play, Bubblebath.",
         similarArtists: ["Lana Del Rey", "Britney Spears", "Some Artist", "Eminem i guess", "More dummy entries"])
         
         */
        
    }
}
