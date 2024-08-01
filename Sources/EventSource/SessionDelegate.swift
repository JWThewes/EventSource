//
//  SessionDelegate.swift
//  EventSource
//
//  Copyright © 2023 Firdavs Khaydarov (Recouse). All rights reserved.
//  Licensed under the MIT License.
//

import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

open class SessionDelegate: NSObject, URLSessionDataDelegate {
    enum Event {
        case didCompleteWithError(Error?)
        case didReceiveResponse(URLResponse, (URLSession.ResponseDisposition) -> Void)
        case didReceiveData(Data)
    }
    
    var onEvent: (Event) -> Void = { _ in }
    
    public func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didCompleteWithError error: Error?
    ) {
        onEvent(.didCompleteWithError(error))
    }
    
    public func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse,
        completionHandler: @escaping (URLSession.ResponseDisposition) -> Void
    ) {
        onEvent(.didReceiveResponse(response, completionHandler))
    }
    
    public func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive data: Data
    ) {
        onEvent(.didReceiveData(data))
    }
}
