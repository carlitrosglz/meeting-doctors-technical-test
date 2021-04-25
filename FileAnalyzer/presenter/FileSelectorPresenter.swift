//
//  FileSelectorPresenter.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 24/4/21.
//

import Foundation

class FileSelectorPresenter {
    private let TAG_FIND_FILES = "TAG_FIND_FILES"
    
    private var view: FileSelectorDelegate
    private var list: Array<FileObject>?
    
    private let service = AnalyzerService()
    
    init(view: FileSelectorDelegate) {
        self.view = view
        
        list = Array()
    }
    
    private func processData(result: [String]) {
        for item in result {
            if item.hasSuffix(".txt") {
                let name = item.replacingOccurrences(of: ".txt", with: "")
                let fileType = ".txt"
                let path = FileHelper.getFilePathFromBundle(fileName: name, fileType: fileType)

                list?.append(FileObject(name: name, fileType: fileType, path: path))
            }
        }
    }
    
    public func getData() {        
        onExecuteOperation(operation: TAG_FIND_FILES)
    }
    
    public func getList() -> Array<FileObject> {
        return list!
    }
}

// MARK: OPERATIONPROTOCOL
extension FileSelectorPresenter: OperationProtocol {
    func onExecuteOperation(operation: String) {
        let operationObject = OperationObject(operation: operation)
        
        switch operation {
            case TAG_FIND_FILES:
                operationObject.setMsgError(error: "Se ha producido un error al intentar recuperar los ficheros.")
                
                service.getFiles(
                    delegate: self,
                    operationObject: operationObject,
                    list: &list!) {
                        [weak self] (result) in
                            if result != nil {
                                self?.processData(result: result!)
                            }
                           
                            self?.onResponseOperation(response: operationObject)
                }
                
            default:
                return
        }
    }
    
    func onResponseOperation(response: OperationObject) {
        if response.isOk() {
            switch response.getOperation() {
                case TAG_FIND_FILES:
                    view.updateData()
                    
                default:
                    return
            }
        }
    }
}
