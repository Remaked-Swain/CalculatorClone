//
//  FileManager.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/07.
//

import Foundation

class LocalFileManager {
    static let shared = LocalFileManager()
    
    private let folderName: String = "ExchangeRateJSON"
    private let fileName: String = "CurrentExchangeRate"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func getDocumentDirectoryURL() -> URL? {
        // 디렉토리 경로 확인
        guard let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("디렉토리 경로를 찾을 수 없습니다.")
            return nil
        }
        // 디렉토리 경로 반환
        return documentDirectoryURL
    }
    
    private func getFolderURL() -> URL? {
        guard let documentDirectoryURL = getDocumentDirectoryURL() else { return nil }
        let folderURL = documentDirectoryURL.appendingPathComponent(folderName, conformingTo: .folder)
        return folderURL
    }
    
    private func getJSONFileURL() -> URL? {
        guard let folderURL = getFolderURL() else { return nil }
        let fileURL = folderURL.appendingPathComponent(fileName, conformingTo: .json)
        return fileURL
    }
    
    private func createFolderIfNeeded() {
        // 디렉토리 내 폴더 확인
        guard let folderURL = getFolderURL() else { return }
        
        // 폴더가 존재하지 않을 경우 생성
        if !FileManager.default.fileExists(atPath: folderURL.path()) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
                print("폴더 생성")
            } catch let error {
                print("폴더 생성간 에러 발생: \(error)")
            }
        }
    }
    
    func saveJSONFile(data: Data) {
        guard let jsonFileURL = getJSONFileURL() else { return }
        
        do {
            try data.write(to: jsonFileURL)
            print("다운로드 및 파일 저장")
        } catch let error {
            print("파일 저장 실패: \(error)")
        }
    }
    
    func fetchJSONFile() -> Data? {
        guard let jsonFileURL = getJSONFileURL(), FileManager.default.fileExists(atPath: jsonFileURL.path) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: jsonFileURL)
            return data
        } catch let error {
            print("파일을 찾을 수 없습니다. \(error)")
            return nil
        }
    }
}
