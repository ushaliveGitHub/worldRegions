//
//  LoadWorldData.swift
//  worldRegions
//
//  Created by Usha Natarajan on 9/3/17.
//  Copyright © 2017 Usha Natarajan. All rights reserved.
//

import Foundation
//MARK: Extension to upload world JSON datafile.

extension RegionsViewController {
    func loadWorldData(completion:@escaping (_ result:Result<Any>)->Void)->Void{
        
        guard let fileName = Bundle.main.path(forResource: "WorldData", ofType:"json")else{
            let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Missing Data file", comment: "")]
            let error = NSError(domain:DataErrorDomain, code: MissingDataError,userInfo:userInfo)
            completion(.failure(error))
            return
        }
       
        DispatchQueue.global(qos: .background).async{
            do{
                let data:Data?
                data = try Data(contentsOf: URL(fileURLWithPath: fileName),options:.uncached)
                guard let result = data else{
                    let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Data not found", comment: "")]
                    let error = NSError(domain:DataErrorDomain, code: MissingDataError,userInfo:userInfo)
                    completion(.failure(error))//if data is nil
                }
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: result, options:.allowFragments ) as? [[String : Any]]
                    let countries = jsonData?.flatMap{country in
                        return Country(json: country)
                    }
                    completion(.success(countries!))
                }catch let error{
                    completion(.failure(error))//unable to convert to json
                }
            }catch let error{
                completion(.failure(error))// file error
            }
        }
    }//end of func loadWorldData
}//end of extension
