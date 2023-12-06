//
//  ContentView.swift
//  StrickerMemo
//
//  Created by 송성욱 on 12/6/23.
//

import SwiftUI

struct MemoListView: View {
    
    @StateObject private var memoStore: MemoStore = MemoStore()
    @State private var memo: Memo = Memo(title: "", desc: "", date: Date())
    @State private var isShowingAddSheet: Bool = false
    @State private var isShowingEditSheet: Bool = false
    var body: some View {
        NavigationStack {
            List(memoStore.memos) { memo in
                        Button {
                            self.memo = memo
                            isShowingEditSheet.toggle()
                        } label: {
                            MemoView(memoStore: memoStore, memo: memo)
                                .listRowSeparator(.hidden)
                        }
            }
            .listStyle(.plain)
            .navigationTitle(memoStore.memos.isEmpty ? "Add Memo" : "Memo (\(memoStore.memos.count))")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddSheet.toggle()
                    } label: {
                        Image(systemName: "pencil.tip.crop.circle.badge.plus")
                            .foregroundStyle(Color.primary)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSheet, content: {
                MemoAddView(memoStore: memoStore, isShowingAddSheet: $isShowingAddSheet, memo: memo)
            })
            .sheet(isPresented: $isShowingEditSheet, content: {
                MemoEditView(memoStore: memoStore, memo: memo, isShowingEditSheet: $isShowingEditSheet)
            })
            .refreshable {
                memoStore.fetchMemos()
            }
            .onAppear {
                memoStore.fetchMemos()
            }
            
            
            
        }
    }
}

#Preview {
    MemoListView()
}
