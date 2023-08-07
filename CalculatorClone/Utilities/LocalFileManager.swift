//
//  FileManager.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/07.
//

import Foundation

class LocalFileManager {
    static let shared = LocalFileManager()
    
    private init() {}
    
    private func getPathForJSONFile(fileName: String) -> URL? {
        // FileManager 캐시디렉토리 내 해당 이름을 가진 파일로의 경로를 지정
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("\(fileName)", conformingTo: .json)
        else { print("파일로의 경로를 찾을 수 없습니다."); return nil }
        
        return path
    }
    
    func saveJSONFile(data: Data, fileName: String) {
        guard let path = getPathForJSONFile(fileName: fileName) else { return }
        
        do {
            try data.write(to: path)
        } catch let error {
            print("파일 저장 실패: \(error)")
        }
    }
    
    func fetchJSONFile(fileName: String) -> Data? {
        guard
            let path = getPathForJSONFile(fileName: fileName),
            FileManager.default.fileExists(atPath: path.path())
        else { return nil }
        
        do {
            let data = try Data(contentsOf: path)
            return data
        } catch let error {
            print("파일을 찾을 수 없습니다. \(error)"); return nil
        }
    }
}
