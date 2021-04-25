//
//  AnalyzerService.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 25/4/21.
//

import RxCocoa
import RxSwift

class AnalyzerService {
    public func getFiles(delegate: OperationProtocol, operationObject: OperationObject, completion: @escaping ([String]?) -> Void) {
        _ = Observable<[String]>.create({ (observer) -> Disposable in
                        
            observer.on(.next(FileHelper.getResourceList()))
            
            return Disposables.create()
        })
        .subscribeOn(getInstanceToSubscribeOn())
            .observeOn(getInstanceToObserveOn())
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
    
    public func getWordsFromFile(delegate: OperationProtocol, operationObject: OperationObject, file: FileObject, completion: @escaping (Array<WordObject>) -> Void) {
        _ = Observable<Array<WordObject>>.create({ (observer) -> Disposable in
                        
            observer.on(.next(FileHelper.readWordsFromFile(file: file, separator: " ")))
            
            return Disposables.create()
        })
        .subscribeOn(getInstanceToSubscribeOn())
            .observeOn(getInstanceToObserveOn())
            .subscribe(
                onNext: { (element) in
                    completion(element)
                },
                onError: { (error) in
                    operationObject.activateError()
                    // completion(nil)
                }
            )
    }
    
    private func getInstanceToObserveOn() -> ImmediateSchedulerType {
        return MainScheduler.instance
    }
    
    private func getInstanceToSubscribeOn() -> ImmediateSchedulerType {
        return ConcurrentDispatchQueueScheduler(qos: .default)
    }
}
