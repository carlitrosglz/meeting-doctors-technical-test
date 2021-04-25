//
//  FileObject.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 24/4/21.
//

import Foundation

class FileObject {
    private var name: String?
    private var fileType: String?
    private var path: String?
    
    init(name: String, fileType: String, path: String) {
        self.name     = name
        self.fileType = fileType
        self.path     = path
    }
    
    public func getName() -> String {
        return name!
    }
    
    public func getFileType() -> String {
        return fileType!
    }
    
    public func getPath() -> String {
        return path!
    }
}
