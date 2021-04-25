//
//  AnalysisResultPresenter.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 25/4/21.
//

import Foundation

class AnalysisResultPresenter {
    private let TAG_ANALYZE_FILE = "TAG_ANALYZE_FILE"
    
    private let service = AnalyzerService()
    
    private var view: AnalysisResultDelegate?
    private var file: FileObject?
    
    private var list: Array<WordObject>?
    private var filteredList: Array<WordObject>?
    private var isFiltering: Bool?
    
    init(_ file: FileObject, view: AnalysisResultDelegate) {
        self.view = view
        self.file = file
        
        list         = Array()
        filteredList = Array()
        
        isFiltering = false
    }
    
    // MARK: PRIVATE FUNCTIONS
    private func isSearchTextBlank(_ text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespaces).count <= 0
    }
    
    private func fillFilteredList(_ text: String) {
        filteredList?.removeAll()
        
        for word in list! {
            if word.getText().lowercased().contains(text) {
                filteredList?.append(word)
            }
        }
    }
    
    // MARK: PUBLIC FUNCTIONS
    public func getData() {
        onExecuteOperation(operation: TAG_ANALYZE_FILE)
    }
    
    public func filterList(text: String) {
        if isSearchTextBlank(text) {
            isFiltering = false
            
        } else {
            isFiltering = true
            fillFilteredList(text)
        }
        
        view?.updateData()
    }
    
    public func getList() -> Array<WordObject> {
        return list!
    }
    
    public func getFilteredList() -> Array<WordObject> {
        return filteredList!
    }
    
    public func isFilterActive() -> Bool {
        return isFiltering!
    }
}

extension AnalysisResultPresenter: OperationProtocol {
    func onExecuteOperation(operation: String) {
        let operationObject = OperationObject(operation: operation)
        
        switch operation {
            case TAG_ANALYZE_FILE:
                service.getWordsFromFile(
                    delegate: self,
                    operationObject: operationObject,
                    file: file!) {
                        [weak self] (result) in
                            self?.list = result
                            self?.onResponseOperation(response: operationObject)
                }
                
            default:
                return
        }
    }
    
    func onResponseOperation(response: OperationObject) {
        if response.isOk() {
            switch response.getOperation() {
                case TAG_ANALYZE_FILE:
                    view!.updateData()
                    
                default:
                    return
            }
        }
    }
}
