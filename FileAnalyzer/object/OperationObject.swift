//
//  OperationObject.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 25/4/21.
//

import Foundation

class OperationObject {
    private var operation: String?
    private var msg_error: String?
    private var is_operation_ok: Bool?
    
    init(operation: String) {
        self.operation = operation
        self.is_operation_ok = true
    }
    
    public func getOperation() -> String {
        return operation!
    }
    
    public func setMsgError(error: String) {
        self.msg_error = error
    }
    
    public func isOk() -> Bool {
        return is_operation_ok!
    }
    
    public func activateError() {
        self.is_operation_ok = false
    }
}
