/*import SwiftUI

struct FilterMenuView: View {
    @Binding var selectedFilters: Set<String>

    let filterOptions = ["Time", "Gender", "Type", "Skill Level"] // Example filter options

    var body: some View {
        List {
            ForEach(filterOptions, id: \.self) { option in
                Button(action: {
                    if selectedFilters.contains(option) {
                        selectedFilters.remove(option)
                    } else {
                        selectedFilters.insert(option)
                    }
                }) {
                    HStack {
                        Text(option)
                        Spacer()
                        if selectedFilters.contains(option) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    FilterMenuView(selectedFilters:.constant([]))
}
*/
