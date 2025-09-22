import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // App title & tagline
                    VStack(spacing: 6) {
                        Text("Xplora")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Discover more, turning aspirations into life")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    // Navigation cards
                    VStack(spacing: 20) {
                        NavigationLink(destination: Badges()) {
                            MenuCard(title: "Badges", icon: "star.fill", color: .yellow)
                        }
                        NavigationLink(destination: Quest_page()) {
                            MenuCard(title: "Quests", icon: "map.fill", color: .green)
                        }
                        NavigationLink(destination: TodoListView(viewModel: TaskViewModel())) {
                            MenuCard(title: "To-Do List", icon: "checkmark.circle.fill", color: .blue)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

// MARK: - Reusable Card View
struct MenuCard: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.8))
                .clipShape(Circle())
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
