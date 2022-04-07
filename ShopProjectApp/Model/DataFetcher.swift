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

    var userData = ["user1","user2","user3","user4","user5","user6"
                    ,"user7","user8","user9","user10","user11","user12","user13","user14","user15"
                    ,"user16","user17","user18","user19","user20","user21","user22","user23","user23.5"
                    ,"user24","user25","user26","user27","user28","user29","user30","user31","user32"]
    
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[Int], Error>)->Void){
        guard getFetchFunctionCount < db.itemsList.count else{
            print("no more data")
            if pagination{
                isPaginating = false
            }
            return
        }
        
        if pagination{
            isPaginating = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: { [self] in
            
            let originalIndexData = [0,1,2,3,4]
            var newIndexData = [Int]()
            
            print("inside datafetcher")
            print(getFetchFunctionCount)
            for index in 5*getFetchFunctionCount...(9*getFetchFunctionCount-4*(getFetchFunctionCount-1)){
                    print(index)
                    newIndexData.append(index)
            }
            print(newIndexData)
            completion(.success(pagination ? newIndexData : originalIndexData))
            if pagination{
                isPaginating = false
            }
            getFetchFunctionCount += 1
        })
    }
}
