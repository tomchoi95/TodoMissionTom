import SwiftUI

struct RoundedBackgroundDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.label
                    .font(.headline)
                Spacer()
                Image(systemName: configuration.isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .onTapGesture {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            }
            
            if configuration.isExpanded {
                configuration.content
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .transition(.slide)
            }
        }
        .padding(.horizontal)
    }
}

struct RoundedBackgroundDisclosureView: View {
    var body: some View {
        VStack {
            DisclosureGroup("설정") {
                VStack(alignment: .leading, spacing: 10) {
                    Toggle("알림", isOn: .constant(true))
                    Toggle("위치 서비스", isOn: .constant(false))
                }
                .padding()
            }
            .disclosureGroupStyle(RoundedBackgroundDisclosureStyle())
            .padding()
        }
    }
}

struct RoundedBackgroundDisclosureView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedBackgroundDisclosureView()
    }
}
