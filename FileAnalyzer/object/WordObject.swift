//
//  WordObject.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 25/4/21.
//

import Foundation

class WordObject {
    private var text: String?
    private var count: Int?
    
    init(text: String) {
        self.text = text
        self.count = 1
    }
    
    public func getText() -> String {
        return text!
    }
    
    public func getCount() -> Int {
        return count!
    }
    
    public func addCount() {
        self.count! += 1
    }
}
