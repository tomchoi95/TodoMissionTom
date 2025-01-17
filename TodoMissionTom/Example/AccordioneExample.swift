import SwiftUI

struct AccordionView: View {
    // 옵션 선택 상태를 관리하는 상태 변수
    @State private var selectedOption: String? = nil
    // 아코디언의 확장 상태를 관리하는 상태 변수 (여러 섹션이 동시에 열릴 수 있도록 Set 사용)
    @State private var expandedSections: Set<String> = []

    // 예시 옵션 배열
    let options = ["옵션 1", "옵션 2", "옵션 3"]

    var body: some View {
    
            List {
                ForEach(options, id: \.self) { option in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { expandedSections.contains(option) },
                            set: { newValue in
                                if newValue {
                                    expandedSections.insert(option)
                                } else {
                                    expandedSections.remove(option)
                                }
                            }
                        ),
                        content: {
                            // 상세 콘텐츠: 해당 옵션이 선택되었을 때 표시할 내용을 여기에 추가
                            VStack(alignment: .leading, spacing: 8) {
                                // 예시: 라디오 버튼 또는 텍스트로 옵션 선택 표시
                                Button(action: {
                                    selectedOption = option
                                }) {
                                    HStack {
                                        Image(systemName: selectedOption == option ? "largecircle.fill.circle" : "circle")
                                        Text("\(option) 선택")
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                // 추가 정보 등의 뷰를 추가할 수 있습니다.
                                Text("여기에 \(option)의 추가 설명을 넣을 수 있습니다.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 8)
                        },
                        label: {
                            HStack {
                                Text(option)
                                    .font(.headline)
                                Spacer()
                                // 선택된 옵션인 경우 표시
                                if selectedOption == option {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    )
                    .animation(.easeInOut, value: expandedSections)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("옵션 선택")
        
    }
}

#Preview {
    AccordionView()
}
