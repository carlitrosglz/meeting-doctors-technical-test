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
    
    init(_ file: FileObject, view: AnalysisResultDelegate) {
        self.view = view
        self.file = file
        
        list = Array()
    }
    
    public func getData() {
        onExecuteOperation(operation: TAG_ANALYZE_FILE)
    }
    
    public func getList() -> Array<WordObject> {
        return list!
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
