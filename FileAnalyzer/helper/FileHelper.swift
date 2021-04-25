//
//  FileHelper.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 24/4/21.
//

import Foundation

class FileHelper {
    class func getResourceList() -> [String] {
        guard let resourcePath = Bundle.main.resourcePath else { return [] }
        
        do {
            let resources = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
            return resources
            
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    class func getFilePathFromBundle(fileName: String, fileType: String) -> String {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            return path
        }
        
        return ""
    }
}
