//
//  MemoStore.swift
//  StrickerMemo
//
//  Created by 송성욱 on 12/6/23.
//

import Foundation
import SwiftUI

class MemoStore: ObservableObject {
    @Published var memos: [Memo] = []

    func fetchMemos() {
        do {
            if let data = UserDefaults.standard.object(forKey: "StickerMemo") as? Data {
                let decoder: JSONDecoder = JSONDecoder()
                memos = try decoder.decode([Memo].self, from: data)
            }
        } catch {
            print("UserDefaults로 부터 데이터 가져오기 실패...")
        }
    }
    
    func saveMemos() {
        do {
            let encoder: JSONEncoder = JSONEncoder()
            let data: Data = try encoder.encode(memos)
            UserDefaults.standard.set(data, forKey: "StickerMemo")
        } catch {
            print("JSON 생성 후 UserDefaults 저장 실패")
        }
    }
    
    func addMemo(title: String, desc: String, color: Color) {
        var memo = Memo(title: title, desc: desc, date: Date())
        memo.color = color
        
        memos.insert(memo, at: 0)
        saveMemos()
    }
    
    func updateMemo(_ memo: Memo) {
        var index: Int = 0
        
        for tempMemo in memos {
            if tempMemo.id == memo.id {
                memos.remove(at: index)
                memos.insert(memo, at: 0)
                saveMemos()
                break
            }
            index += 1
        }
    }
    
    func removeSticker(_ memo: Memo) {
        var index: Int = 0
        
        for tempMemo in memos {
            if tempMemo.id == memo.id {
                memos.remove(at: index)
                saveMemos()
                break
            }
            index += 1
        }
    }
}
