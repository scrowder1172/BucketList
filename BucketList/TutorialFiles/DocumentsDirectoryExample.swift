//
//  DocumentsDirectoryExample.swift
//  BucketList
//
//  Created by SCOTT CROWDER on 1/10/24.
//

import SwiftUI

struct DocumentsDirectoryExample: View {
    
    @State private var directoryLocation: String = ""
    @State private var message: String = ""
    @State private var readMessage: String = ""
    
    var body: some View {
        HStack {
            Button("Print directory") {
                printDocumentsDirectoryLocation()
            }
            .buttonStyle(.bordered)
            Text(directoryLocation)
                .border(Color.black)
        }
        .padding()
        
        VStack {
            HStack {
                TextField("Message", text: $message)
                    .textFieldStyle(.roundedBorder)
                Button("Write Message") {
                    readWriteData()
                }
                .buttonStyle(.bordered)
            }
            Text(readMessage)
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        }
        .padding()
        
    }
    
    func printDocumentsDirectoryLocation() {
        print(URL.documentsDirectory)
        directoryLocation = String(URL.documentsDirectory.path())
    }
    
    func readWriteData() {
        let data: Data = Data(message.utf8)
        let url: URL = URL.documentsDirectory.appending(path: "message.txt")
        
        do {
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            let input = try String(contentsOf: url)
            readMessage = input
//            let output = FileManager.decode("message.txt")
        } catch {
            print(error.localizedDescription)
        }
    }
}

//extension FileManager {
//    func decode<T: Codable>(_ file: String) -> T {
//        let url = URL.documentsDirectory.appending(path: file)
//        
//        guard let fileData = try? Data(contentsOf: url) else {
//            fatalError("Failed to load \(file) from bundle.")
//        }
//        
//        let decoder: JSONDecoder = JSONDecoder()
//        
//        guard let decodedData = try? decoder.decode(T.self, from: fileData) else {
//            fatalError("Failed to decode \(file)")
//        }
//        
//        return decodedData
//    }
//}

#Preview {
    DocumentsDirectoryExample()
}
