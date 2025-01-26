import SwiftUI

struct CustomArrowDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            }) {
                HStack {
                    configuration.label
                        .font(.headline)
                    Spacer()
                    Image(systemName: configuration.isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(configuration.isExpanded ? 180 : 0))
                        .animation(.easeInOut, value: configuration.isExpanded)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            if configuration.isExpanded {
                configuration.content
                    .padding(.leading, 16)
                    .transition(.opacity)
            }
        }
        .padding()
    }
}

struct CustomArrowDisclosureView: View {
    var body: some View {
        VStack {
            DisclosureGroup("더 보기") {
                Text("여기에 상세 내용을 추가하세요.")
                    .padding()
            }
            .disclosureGroupStyle(CustomArrowDisclosureStyle())
            .padding()
        }
    }
}

struct CustomArrowDisclosureView_Previews: PreviewProvider {
    static var previews: some View {
        CustomArrowDisclosureView()
    }
}
