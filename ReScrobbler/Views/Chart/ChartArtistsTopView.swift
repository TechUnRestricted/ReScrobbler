//
//  ArtistsTopView.swift
//  ReScrobbler
//
//  Created on 28.06.2021.
//

import SwiftUI





fileprivate func getData() -> getTopArtists.jsonStruct?{
    /**
        Getting data from URL (online) or from Container data (offline)
     */
    let jsonFolder = fileManager?.appendingPathComponent("jsonStructures")
    let jsonFile = jsonFolder?.appendingPathComponent("ChartArtistsTop.json")
    
     func loadFromInternet() -> getTopArtists.jsonStruct?{
        if let jsonFromInternet = try? JSONDecoder().decode(getTopArtists.jsonStruct.self, from:getJSONFromUrl("method=chart.gettopartists&limit=100")){
            print("[LOG]:> {ArtistsTopView} Loaded JSON struct from <internet>")
            if let encoded = try? JSONEncoder().encode(jsonFromInternet) {
                if let jsonFile = jsonFile{
                    do {
                        try encoded.write(to: jsonFile)
                        print("[LOG]:> JSON <ChartArtistsTop.json> has been saved.")

                    } catch {
                        print("[ERROR]:> Can't write <ChartArtistsTop.json>. {Message: \(error)}")
                    }
                }
            }
            return jsonFromInternet
        }
        else{
            print("[LOG]:> An error has occured while getting data from Internet.")
            return nil
        }
    }
    
    do {
        if let jsonFolder = jsonFolder{
            try FileManager.default.createDirectory(atPath: jsonFolder.path, withIntermediateDirectories: true, attributes: nil)
            print("[LOG]:> Folder <jsonStructures> has been created.")
        }
    } catch {
        print("[ERROR]:> Can't create folder <jsonStructures>. {Message: \(error)}")
    }
    
    print(jsonFolder?.path ?? "[[Can't get path]]")

    if let jsonFile = jsonFile, FileManager.default.fileExists(atPath: jsonFile.path) {

        do{
            let json = try JSONDecoder().decode(getTopArtists.jsonStruct.self, from: Data(contentsOf: jsonFile))
            print("[LOG]:> Loaded local JSON struct from <ChartArtistsTop.json>.")
            return json
        }
        catch{
            print("[ERROR]:> Can't load <ChartArtistsTop.json> from App Container. {Message: \(error)}")
            return loadFromInternet()
        }
    }
    else{
       return loadFromInternet()
    }
}



fileprivate func getArtistInfo(artistName: String) -> getInfoArtist.jsonStruct?{
    /**
        Getting info about single artist from Internet
     */
    if let jsonFromInternet = try? JSONDecoder().decode(getInfoArtist.jsonStruct.self, from:getJSONFromUrl("method=artist.getinfo&artist=" + artistName.urlEncoded!)){
        print("[LOG]:> {ArtistInfoPopUpView} Loaded JSON struct from <internet>")
        
        return jsonFromInternet
    }
    else{
        print("[LOG]:> An error has occured while getting data from Internet.")
    }
    return nil
}

fileprivate struct ArtistInfoPopUpHandler: View{
    var chosenArtistName : String
    @Binding var showingModal : Bool

    var body: some View{
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
        
        
        /*Start*/
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(){
                HStack{
                    
                    ZStack{
                        Text(artistInfo?.name ?? "")
                            .font(.system(size: 30))
                            .fontWeight(.light)
                            .lineLimit(1)
                            .padding([.top, .leading, .trailing], 25.0)
                            HStack{
                                VStack{
                                    ColoredRoundedButton(title: "Close", action:{ showingModal = false}, color: Color.purple)
                                }
                                Spacer()
                                
                            if (artistInfo?.ontour == "1" ? true : false){
                                VStack{
                                    ColoredRoundedButton(title: "On Tour", action: {}, color: Color.purple)
                                }
                            }
                        }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(tagsFormatted, id: \.self){ tag in
                            ColoredRoundedButton(title: tag ?? "Unknown Tag", action: {}, color: Color.random)
                        }
                    }
                }.clipShape(Capsule())
                
                HStack{
                    Group{
                        Text("Listeners: " + (artistInfo?.stats?.listeners?.roundedWithAbbreviations ?? ""))
                        Text("Play Count: " + (artistInfo?.stats?.playcount?.roundedWithAbbreviations ?? ""))
                    }
                    .padding(.horizontal)
                    .font(.system(size: 15))
                    .opacity(0.8)
                }
                Group{
                    if ((artistInfo?.bio?.summary) != nil){
                        VStack(alignment: .leading){
                            Text("About artist:")
                                .font(.system(size: 20))
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            
                            Text(artistInfo?.bio?.summary?.withoutHtmlTags ?? "No information provided")
                                .font(.system(size: 15))
                                .fontWeight(.light)
                                .fixedSize(horizontal: false, vertical: true)
                            
                        }.padding(.top, 10)
                    }
                    if similarArtistsFormatted != []{
                        VStack(alignment: .leading){
                            Text("Similar artists:")
                                .font(.system(size: 20))
                                .padding(.leading, 15.0)
                                .padding(.bottom, 0.5)
                            VStack(spacing: 5.0){
                                ForEach(0..<similarArtistsFormatted.count){ index in
                                    SimilarArtistButton(artistName: similarArtistsFormatted[index] ?? "Unknown Artist", index: index+1, action: {})
                                }
                            }
                            
                        }.padding(.top, 10)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
            }
            
            
        }
        .padding(.horizontal, 22.0)
        .frame(minWidth: 200, maxWidth: 800, maxHeight: 600)
        .background(Color(NSColor.windowBackgroundColor))
        .cornerRadius(13)
        
        /*End*/
            .frame(
                minWidth: 360,
                maxWidth: .infinity,
                minHeight: 480,
                maxHeight: .infinity,
                alignment: .center
            )
            
            .background(Color.gray.opacity(0.5))
            /*.onTapGesture {
                withAnimation{
                    showAlert = false
                }
            }*/
            .onExitCommand{
                showingModal = false
            }
    
    }
}



fileprivate var chosenArtistName : String = ""

struct ChartArtistsTopView: View {
    @State var showingModal = false
    var body: some View {
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
                                            print("Pressing -> \(artistName)")
                                            chosenArtistName = artistName
                                            showingModal = true
                                        }
                                      
                                    }
                                }
                                
                                
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                
            }
            .sheet(
                isPresented: $showingModal,
                content: {ArtistInfoPopUpHandler(chosenArtistName: chosenArtistName, showingModal: $showingModal) }
            )
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
