//
//  APIClient.swift
//  FortniteShopApp
//
//  Created by Archichil on 18.10.24.
//

import Foundation

struct APIClient {
    private let baseUrl: URL
    private let urlSession: URLSession
    
    init(baseUrl: URL, URLSession: URLSession = URLSession.shared) {
        self.baseUrl = baseUrl
        self.urlSession = URLSession
    }
    
    public func sendRequest(_ apiSpec: APISpec) async throws -> DecodableType {
        guard let url = URL(string: baseUrl.absoluteString + apiSpec.endpoint) else {
            throw NetworkError.invalidRequestURL
        }
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: TimeInterval(floatLiteral: 30.0)
        )
        request.httpMethod = apiSpec.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = apiSpec.body
        
        var responseData: Data? = nil
        var urlResponse: URLResponse
        do {
            let (data, response) = try await urlSession.data(for: request)
            try handleResponse(data: data, response: response, request: request)
            responseData = data
            urlResponse = response
        } catch {
            throw error
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(
                apiSpec.returnType,
                from: responseData!
            )
            return decodedData
        } catch let error as DecodingError {
            throw NetworkError.responseDecodingFailed(
                type: apiSpec.returnType,
                response: Response(data: responseData!, urlRequest: request, httpUrlResponse: urlResponse as! HTTPURLResponse)
            )
        } catch {
            throw NetworkError.dataConversionFailure
        }
    }
    
    private func handleResponse(data: Data, response: URLResponse, request: URLRequest) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.unacceptableStatusCode(
                statusCode: httpResponse.statusCode,
                response: Response(data: data, urlRequest: request, httpUrlResponse: response as! HTTPURLResponse)
            )
        }
    }
}

extension APIClient {
    protocol APISpec {
        var endpoint: String { get }
        var method: HttpMethod { get }
        var returnType: DecodableType.Type { get }
        var body: Data? { get }
    }
    
    enum HttpMethod: String, CaseIterable {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case put = "PUT"
        case delete = "DELETE"
        case head = "HEAD"
        case options = "OPTIONS"
    }
}

protocol DecodableType: Decodable { }

extension Array: DecodableType where Element: DecodableType { }
