//
//  DropDown.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-17.
//

import SwiftUI

struct DropdownExampleView: View {
    // 선택된 옵션을 관리하는 상태 변수
    @State private var selectedOption: String = "옵션 1"
    
    // 선택 가능한 옵션 배열
    let options: [String] = ["옵션 1", "옵션 2", "옵션 3", "옵션 4"]
    
    var body: some View {
        VStack(spacing: 20) {
            // 드롭다운 메뉴 구현
            Menu {
                // ForEach를 통해 각 옵션에 대한 버튼 생성
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        // 옵션 선택 시 상태 변수 업데이트
                        selectedOption = option
                    }) {
                        Text(option)
                        // 현재 선택된 옵션은 체크표시 표시 (조건부로 아이콘 추가)
                        if selectedOption == option {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            } label: {
                // 드롭다운 메뉴의 라벨: 현재 선택된 옵션을 표시하고, 화살표 아이콘 추가
                HStack {
                    Text(selectedOption)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("드롭다운 예제")
    }
}

struct DropdownExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DropdownExampleView()
        }
    }
}
