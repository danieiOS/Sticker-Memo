//
//  MemoEditView.swift
//  StrickerMemo
//
//  Created by 송성욱 on 12/6/23.
//

import SwiftUI

struct MemoEditView: View {
    var memoStore: MemoStore
    @State var memo: Memo
    @Binding var isShowingEditSheet: Bool
    @State var selectedColor: Color = .cyan
    @State private var title: String = ""
    @State private var desc: String = ""
    let colors: [Color] = [.cyan, .purple, .blue, .yellow, .brown]
    @Environment(\.dismiss) var dismiss
    
    
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
                Text("Write a contents")
                    .font(.title3)
                    .padding(.vertical)
                
                TextField(memo.title.isEmpty ? "제목을 입력하세요" : "제목을 수정하세요", text: $title, axis: .vertical)
                    .font(.headline)
                Divider()
                    .padding(.vertical)
                TextField(memo.desc.isEmpty ? "내용을 입력하세요" : "내용을 수정하세요", text: $desc, axis: .vertical)
                    .font(.body)
                Spacer()
            }
            .padding()
            .navigationTitle("Edit Memo")
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
                        memo.color = selectedColor
                        memo.title = title
                        memo.desc = desc
                        memo.date = Date()
                        memoStore.updateMemo(memo)
                        dismiss()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    MemoEditView(memoStore: MemoStore(), memo: Memo(title: "", desc: "", date: Date()), isShowingEditSheet: .constant(true))
}

struct MemoColorSelectView: View {
    @Binding var selectedColor: Color
    let color: Color
    
    var body: some View {
        Button {
            selectColor()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .foregroundColor(color)
                    .shadow(radius: 6)
                    .frame(height: 60 )
                
                if selectedColor == color {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    func selectColor() {
        selectedColor = color
        print("\(selectedColor) / \(color)")
    }
}
