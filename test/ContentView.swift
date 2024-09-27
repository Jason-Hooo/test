//
//  ContentView.swift
//  test
//
//  Created by 何杰陞 on 2024/8/28.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isShortcutVisible = false
    @State private var dragOffset = CGSize.zero

    var body: some View {
        ZStack {
            // 主界面内容
            VStack {
                Text("App Main Content")
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
            
            // 模拟的动态岛
            Ellipse()
                .frame(width: 200, height: 50)
                .foregroundColor(Color.black.opacity(0.8))
                .overlay(
                    Text("Dynamic Island")
                        .foregroundColor(.white)
                )
                .position(x: UIScreen.main.bounds.width / 2, y: 80)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // 检测向下滑动
                            if value.translation.height > 10 {
                                withAnimation {
                                    self.isShortcutVisible = true
                                    self.dragOffset = value.translation
                                }
                            }
                        }
                        .onEnded { _ in
                            withAnimation {
                                self.dragOffset = .zero
                            }
                        }
                )
            
            // 快捷方式窗口
            if isShortcutVisible {
                ShortcutPopup(isVisible: $isShortcutVisible)
                    .offset(y: dragOffset.height)
                    .transition(.move(edge: .top))
            }
        }
    }
}

struct ShortcutPopup: View {
    @Binding var isVisible: Bool

    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                print("Shortcut 1 tapped")
            }) {
                Text("Open Feature 1")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                print("Shortcut 2 tapped")
            }) {
                Text("Open Feature 2")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            Button(action: {
                withAnimation {
                    isVisible = false
                }
            }) {
                Text("Close")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.black.opacity(0.9))
        .cornerRadius(20)
        .padding(.top, 100)  // 调整窗口的显示位置
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
