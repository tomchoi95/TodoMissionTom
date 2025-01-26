import SwiftUI

struct ShadowedDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation(.spring()) {
                    configuration.isExpanded.toggle()
                }
            }) {
                HStack {
                    configuration.label
                        .font(.headline)
                    Spacer()
                    Image(systemName: configuration.isExpanded ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                        .rotationEffect(.degrees(configuration.isExpanded ? 180 : 0))
                        .animation(.easeInOut, value: configuration.isExpanded)
                }
                .padding()
                .background(Color.white)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
            }
            .buttonStyle(PlainButtonStyle())
            
            if configuration.isExpanded {
                configuration.content
                    .padding()
                    .background(Color.white)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(10)
        .padding()
    }
}

struct ShadowedDisclosureView: View {
    var body: some View {
        VStack {
            DisclosureGroup("프로필") {
                VStack(alignment: .leading, spacing: 10) {
                    Text("이름: 최범수")
                    Text("이메일: example@example.com")
                }
                .padding()
            }
            .disclosureGroupStyle(ShadowedDisclosureStyle())
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct ShadowedDisclosureView_Previews: PreviewProvider {
    static var previews: some View {
        ShadowedDisclosureView()
    }
}
