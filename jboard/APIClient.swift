//
//  APIEndpoint.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import Alamofire

struct APIClient {
    
    enum Router: URLRequestConvertible {
        #if DEBUG
        static let baseURLString = "https://jboard-api-staging.herokuapp.com/"
        #else
        static let baseURLString = "https://jboard-api.herokuapp.com/"
        #endif
        case home
        case loginFacebook(token:String)
        case currentUser
        case register(user:User)
        case positions(filter: String?)
        case position(id:Int)
        case companyPositions(id:Int)
        case createPosition(position:Position)
        case updatePosition(position:Position)
        case deletePosition(position:Position)
        case companies
        case company(id:Int)
        case employers
        case employer(id:Int)
        case createEmployer(employer:Employer)
        case updateEmployer(employer:Employer)
        case deleteEmployer(employer:Employer)
        case resume
        case createResume(resume:Resume)
        case updateResume(resume:Resume)
        case resumes
        case deleteResume
        case bookmarks
        case bookmark(id:Int)
        case createPositionBookmark(position:Position, status:String)
        case updatePositionBookmark(position:Position, status:String)
        
        
        var method: HTTPMethod {
            switch self {
            case .loginFacebook(_): return .post
            case .register(_): return .post
            case .createPosition(_): return .post
            case .updatePosition(_): return .put
            case .deletePosition(_): return .delete
            case .createResume(_): return .post;
            case .updateResume(_): return .put;
            case .deleteResume: return .delete;
            case .createEmployer(_): return .post;
            case .updateEmployer(_): return .put;
            case .deleteEmployer(_): return .delete;
            case .createPositionBookmark(_, _): return .post;
            case .updatePositionBookmark(_, _): return .put;
            default: return .get
            }
        }
        
        var path: String {
            switch self {
            case .home: return "/"
            case .loginFacebook(_): return "api/v1/login/facebook"
            case .currentUser: return "api/v1/user"
            case .register(_): return "api/v1/register"
            case .positions: return "api/v1/positions"
            case .position(let id): return "api/v1/positions/\(id)"
            case .companyPositions(let id): return "api/v1/companies/\(id)/positions"
            case .createPosition(let position):  return "api/v1/companies/\(position.company_id)/positions"
            case .updatePosition(let position), .deletePosition(let position): return "api/v1/companies/\(position.company_id)/positions/\(position.id)"
            case .companies: return "api/v1/companies"
            case .company(let id): return "api/v1/companies/\(id)"
            case .employers: return "api/v1/employers"
            case .employer(let id): return "api/v1/employers/\(id)"
            case .createEmployer(_): return "api/v1/employers/"
            case .updateEmployer(let employer), .deleteEmployer(let employer): return "api/v1/employers/\(employer.id)"
            case .resume, .createResume(_), .updateResume(_), .deleteResume: return "api/v1/resume"
            case .resumes: return "/api/v1/resumes"
            case .bookmarks: return "api/v1/bookmarks"
            case .bookmark(let id): return "api/v1/bookmarks/\(id)"
            case .createPositionBookmark(let position, let status), .updatePositionBookmark(let position, let status): return "api/v1/positions/\(position.id)/mark/\(status)";
            }
        }
        
        var params: [String: AnyObject] {
            switch self {
            case .loginFacebook(let token):
                return ["token":token as AnyObject]
            case .register(let user):
                return user.toDict(exclude: ["id", "gravatarUrl"]) as [String : AnyObject]
            case .positions(let filter):
                guard let str = filter else { return [:] }
                return ["filter": str as AnyObject]       
            case .createPosition(let position), .updatePosition(let position):
                return position.toDict(exclude: ["id", "company", "contacts"]) as [String : AnyObject]
            case .createResume(let resume), .updateResume(let resume):
                return resume.toDict(exclude: ["id", "user"]) as [String : AnyObject]
            case .createEmployer(let employer), .updateEmployer(let employer):
                return employer.toDict(exclude: ["id", "company", "contacts"]) as [String : AnyObject]
            default: return [:]
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let baseURL = try Router.baseURLString.asURL()
            var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            if let token = Secret.apiToken.value {
                urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
            }
            return try URLEncoding.default.encode(urlRequest, with: params)
        }
    }
    
}
