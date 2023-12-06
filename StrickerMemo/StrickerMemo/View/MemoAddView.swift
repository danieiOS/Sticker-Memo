//
//  MemoAddView.swift
//  StrickerMemo
//
//  Created by 송성욱 on 12/6/23.
//

import SwiftUI

struct MemoAddView: View {
    
    var memoStore: MemoStore
    @Binding var isShowingAddSheet: Bool
    @State var selectedColor: Color = .cyan
    @State private var title: String = ""
    @State private var desc: String = ""
    let colors: [Color] = [.cyan, .purple, .blue, .yellow, .brown]
    @Environment(\.dismiss) var dismiss
    @State var memo: Memo
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Select a color")
                    .font(.title)
                HStack {
                    ForEach(colors, id: \.self) { color in
                        MemoColorSelectView(selectedColor: $selectedColor, color: color)
                    }
                }
                Text("Write a memo")
                    .font(.title3)
                    .padding(.vertical)
                HStack {
                    TextField("제목을 입력하세요", text: $title, axis: .vertical)
                        .font(.headline)
                    Button {
                        title = ""
                    } label: {
                        Image(systemName: title.isEmpty ? "" : "xmark.circle")
                    }
                }
                Divider()
                    .padding(.vertical)
                HStack {
                    TextField("내용을 입력하세요", text: $desc, axis: .vertical)
                        .font(.body)
                    Button {
                        desc = ""
                    } label: {
                        Image(systemName: desc.isEmpty ? "" : "xmark.circle")
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Add Memo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        memoStore.addMemo(title: title, desc: desc, color: selectedColor)
                       
                        dismiss()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(title == "" || desc == "")
                }
            }
        }
    }
}

#Preview {
    MemoAddView(memoStore: MemoStore(), isShowingAddSheet: .constant(true), memo: Memo(title: "", desc: "", date: Date()))
}
