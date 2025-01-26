import SwiftUI

// 1. Custom Colored DisclosureGroup with Gradient Background
struct ColorfulDisclosureGroup: View {
    @State private var isExpanded = false
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                VStack(alignment: .leading) {
                    Text("Detailed content goes here")
                    Text("More information")
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.blue.opacity(0.3)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            },
            label: {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Colorful Disclosure")
                        .foregroundColor(.blue)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue.opacity(0.2))
                )
            }
        )
    }
}

// 2. Animated DisclosureGroup with Custom Icon Rotation
struct AnimatedDisclosureGroup: View {
    @State private var isExpanded = false
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                Text("Animated content reveals smoothly")
                    .padding()
            },
            label: {
                HStack {
                    Text("Animated Disclosure")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        .animation(.spring(), value: isExpanded)
                }
            }
        )
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue, lineWidth: 1)
        )
    }
}

// 3. Multi-Level Nested DisclosureGroup
struct NestedDisclosureGroup: View {
    var body: some View {
        DisclosureGroup("Main Category") {
            DisclosureGroup("Subcategory 1") {
                Text("Detailed content for Subcategory 1")
            }
            
            DisclosureGroup("Subcategory 2") {
                Text("Detailed content for Subcategory 2")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}

// 4. DisclosureGroup with Custom Styling and Conditional Content
struct ConditionalDisclosureGroup: View {
    @State private var selectedItem: String? = nil
    let items = ["Option 1", "Option 2", "Option 3"]
    
    var body: some View {
        DisclosureGroup("Select an Option") {
            ForEach(items, id: \.self) { item in
                HStack {
                    Text(item)
                    Spacer()
                    if selectedItem == item {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                }
                .onTapGesture {
                    selectedItem = item
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
        )
    }
}

#Preview {
    ColorfulDisclosureGroup()
    AnimatedDisclosureGroup()
    NestedDisclosureGroup()
    ConditionalDisclosureGroup()
}
