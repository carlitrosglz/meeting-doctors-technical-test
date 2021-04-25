//
//  AnalyzerService.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 25/4/21.
//

import RxCocoa
import RxSwift

class AnalyzerService {
    public func getFiles(delegate: OperationProtocol, operationObject: OperationObject, list: inout Array<FileObject>, completion: @escaping ([String]?) -> Void) {
        _ = Observable<[String]>.create({ (observer) -> Disposable in
                        
            observer.on(.next(FileHelper.getResourceList()))
            
            return Disposables.create()
        })
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { (element) in
                    completion(element)
                },
                onError: { (error) in
                    operationObject.activateError()
                    completion(nil)
                }
            )
    }
}
