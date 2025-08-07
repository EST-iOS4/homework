//
//  ContentView.swift
//  Typesetting
//
//  Created by 송영민 on 8/6/25.

import SwiftUI

struct ContentView: View {
    @State private var text: String = """
낡은 시계탑은 마을의 가장 높은 곳에 굳건히 서 있었다. 수십 년 동안 시간을 알려주었지만, 이제는 멈춰버린 채 녹슨 톱니바퀴를 드러낸 채 덩그러니 놓여 있었다. 아이들은 그 탑을 ‘귀신’이라 부르며 감히 가까이 가지 않았다.

어느 날, 어린 소녀 연아가 시계탑 아래 멈춰 선 시간을 엿보러 왔다. 낡은 나무 계단을 조심스럽게 올라, 탑 꼭대기에서 마을 전체를 내려다보았다. 연아의 눈에 들어온 것은 변하지 않는 풍경과, 그 풍경 속에서 빠르게 흘러가는 시간이었다.

탑 안에는 먼지 덮인 물건들이 가득했다. 오래된 사진 한 장이 연아의 시선을 끌었다. 사진 속에는 젊은 남성이 환하게 웃으며 시계탑을 바라보고 있었다. 남자의 얼굴은 희미하게 지워져 있었지만, 연아는 그 눈빛에서 따뜻함과 그리움을 느꼈다.

“시간은 멈출 수 없지만, 기억은 영원히 남는 거예요.”

어둠 속에서 들려오는 듯한 낮은 목소리에 연아는 깜짝 놀랐다. 아무도 없었다. 하지만 연아는 알 수 있었다. 시계탑이 자신에게 말을 건넨 것이었다.

연아는 탑에서 내려와 집으로 돌아갔다. 낡은 사진 속 남자의 미소를 떠올리며, 자신도 언젠가 누군가에게 기억될 순간을 만들어야겠다고 다짐했다. 멈춰버린 시계탑은 연아에게 시간의 소중함과 기억의 의미를 알려주었다.

"""
    @State private var lead: CGFloat = 0.0
    @State private var kern: CGFloat = 0.0
    @State private var typeSize: CGFloat = 24.0

    var body: some View {
        VStack {
            ScrollView {
                Text(text)
                    .font(.system(size: typeSize))
                    .lineSpacing(lead)
                    .kerning(kern)
            }
            VStack {
                HStack {
                    Text("Font size")
                    Text("\(Int(typeSize))").frame(width: 36)
                    Slider(value: $typeSize, in: 12...120, step: 1.0)
                }
                HStack {
                    Text("Letter spacing")
                    Text("\(Int(kern))").frame(width: 36)
                    Slider(value: $kern, in: 0...typeSize, step: 1.0)
                }
                HStack {
                    Text("Line spacing")
                    Text("\(Int(lead))").frame(width: 36)
                    Slider(value: $lead, in: 0...typeSize * 5, step: 1.0)
                }
            }
        }
        .padding()
    }
}

#Preview {
  ContentView()
}
