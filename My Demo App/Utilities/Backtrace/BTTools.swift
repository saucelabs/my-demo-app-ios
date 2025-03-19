//
//  BacktraceTools.swift
//  My Demo App
//
//  Created by Melek R on 2025-03-19.
//

import Foundation

enum CustomError: Error {
    case runtimeError
}

func throwingFunc() throws {
    throw CustomError.runtimeError
}

func createAndWriteFile(_ fileName: String) -> URL? {
    let dirName = "directory"
    
    do {
        let libraryDirectoryUrl = try FileManager.default.url(
            for: .libraryDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        
        let directoryUrl = libraryDirectoryUrl.appendingPathComponent(dirName)
        
        try FileManager.default.createDirectory(
            at: directoryUrl,
            withIntermediateDirectories: true,
            attributes: nil
        )
        
        let fileUrl = directoryUrl.appendingPathComponent(fileName)
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        let myData = formatter.string(from: Date())
        
        try myData.write(to: fileUrl, atomically: true, encoding: .utf8)
        return fileUrl
    } catch {
        print("Error creating file: \(error.localizedDescription)")
        return nil
    }
}
