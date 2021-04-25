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
    
    class func readWordsFromFile(file: FileObject, separator: Character) -> Array<WordObject> {
        let url = Bundle.main.url(forResource: file.getName(), withExtension: file.getFileType())
        let text = try? String(contentsOf: url!)
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\r", with: " ")
            .trimmingCharacters(in: .whitespaces)
            .split(separator: separator)

        return discretizeWords(text: text!)
    }
    
    private class func discretizeWords(text: [String.SubSequence]) -> Array<WordObject> {
        var list = Array<WordObject>()
        
        for word in text {
            let word = String(word).lowercased().trimmingCharacters(in: .whitespaces)
            if !word.isEmpty && !existsWordInList(word, list: list) {
                list.append(WordObject(text: word))
            }
        }
        
        return list
    }
    
    private class func existsWordInList(_ word: String, list: Array<WordObject>) -> Bool {
        for object in list {
            if object.getText().lowercased() == word.lowercased() {
                object.addCount()
                return true
            }
        }
        
        return false
    }
}
