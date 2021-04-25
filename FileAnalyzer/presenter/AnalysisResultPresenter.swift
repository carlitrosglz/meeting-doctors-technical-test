//
//  AnalysisResultPresenter.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 25/4/21.
//

import Foundation

class AnalysisResultPresenter {
    private let service = AnalyzerService()
    
    private var list: Array<WordObject>?
    private var file: FileObject?
    private var view: AnalysisResultDelegate?
    
    init(_ file: FileObject, view: AnalysisResultDelegate) {
        list = Array()
        self.view = view
        self.file = file
        
        onExecuteOperation(operation: "")
    }
    
    public func getList() -> Array<WordObject> {
        return list!
    }
}

extension AnalysisResultPresenter: OperationProtocol {
    func onExecuteOperation(operation: String) {
        let operationObject = OperationObject(operation: operation)
        
        service.getWordsFromFile(
            delegate: self,
            operationObject: operationObject,
            file: file!) {
                [weak self] (result) in
                    self?.list = result
                    self?.onResponseOperation(response: operationObject)
        }
        
        
    }
    
    func onResponseOperation(response: OperationObject) {        
        view!.updateData()
    }
}
