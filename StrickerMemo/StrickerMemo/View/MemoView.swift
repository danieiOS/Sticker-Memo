//
//  MemoView.swift
//  StrickerMemo
//
//  Created by 송성욱 on 12/6/23.
//

import SwiftUI

struct MemoView: View {
    
    var memoStore: MemoStore
    let memo: Memo
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(memo.title)
                    .font(.title)
                    .padding(.horizontal)
                    .padding(.top)
                Text(memo.desc)
                    .font(.headline)
                    .padding(.horizontal)
                Text(memo.dateString)
                    .font(.footnote)
                    .padding()
            }
            Spacer()
        }
        .background(memo.color)
        .shadow(radius: 6)
        .padding()
        .contextMenu {
            ShareLink(item: memo.desc)
        
            Button {
                memoStore.removeSticker(memo)
            } label: {
                Image(systemName: "trash.slash")
                Text("Remove")
            }
        }
    }
}

#Preview {
    MemoView(memoStore: MemoStore(), memo: Memo(title: "Hello", desc: "My name is seongwook", date: Date()))
}
