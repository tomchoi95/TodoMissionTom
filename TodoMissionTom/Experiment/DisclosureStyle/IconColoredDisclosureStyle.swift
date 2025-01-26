import SwiftUI

struct IconColoredDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: configuration.isExpanded ? "folder.open" : "folder")
                    .foregroundColor(.purple)
                configuration.label
                    .font(.headline)
                Spacer()
                Image(systemName: configuration.isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.purple)
            }
            .padding()
            .background(Color.purple.opacity(0.1))
            .cornerRadius(8)
            .onTapGesture {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            }
            
            if configuration.isExpanded {
                configuration.content
                    .padding(.leading, 40)
                    .transition(.scale)
            }
        }
        .padding(.horizontal)
    }
}

struct IconColoredDisclosureView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            DisclosureGroup("문서") {
                VStack(alignment: .leading, spacing: 5) {
                    Text("문서 1")
                    Text("문서 2")
                    Text("문서 3")
                }
                .padding()
            }
            .disclosureGroupStyle(IconColoredDisclosureStyle())
            
            DisclosureGroup("설정") {
                VStack(alignment: .leading, spacing: 5) {
                    Toggle("알림 활성화", isOn: .constant(true))
                    Toggle("자동 업데이트", isOn: .constant(false))
                }
                .padding()
            }
            .disclosureGroupStyle(IconColoredDisclosureStyle())
        }
        .padding()
    }
}

struct IconColoredDisclosureView_Previews: PreviewProvider {
    static var previews: some View {
        IconColoredDisclosureView()
    }
}
