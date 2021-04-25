//
//  OperationProtocol.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 25/4/21.
//

import Foundation

protocol OperationProtocol: class {
    func onExecuteOperation(operation: String)
    func onResponseOperation(response: OperationObject)
}
