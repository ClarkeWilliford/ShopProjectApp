//
//  DataFetcher.swift
//  ShopProjectApp
//
//  Created by John Figueroa on 4/4/22.
//

import Foundation
class DataFetcher{
    var isPaginating = false
    var getFetchFunctionCount = 1
    
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[Int], Error>)->Void){
        guard getFetchFunctionCount < db.itemsList.count else{
            print("out of data")
            return
        }
        if pagination{
            isPaginating = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: { [self] in
            
            let originalIndexData = [0,1,2,3]
            var newIndexData = [Int]()
            
            //print("inside datafetcher")
            for index in 5*getFetchFunctionCount...(9*getFetchFunctionCount-4*(getFetchFunctionCount-1)){
                    //print(index)
                    newIndexData.append(index)
            }
            completion(.success(pagination ? newIndexData : originalIndexData))
            if pagination{
                isPaginating = false
            }
            getFetchFunctionCount += 1
        })
    }
}
