import SwiftUI

struct Badges: View {
    @State private var selectedBadge = 0
    @State private var imageFiles: [String] = Array(repeating: "Placeholder", count: 8)
    
    private let names: [String] = [
        "🥘 Foodie","🚶‍♂️ Walker","⛰️ Hiker","🌱 Grass",
        "💰 RichieRich","⭐ XPerienced","✅ Completionist","🦸‍♂️ Hero"
    ]
    
    private let unlockedImages: [String] = [
        "Foodie", "Walker", "Hiker", "Grass",
        "RichieRich", "XPerienced", "Completionist", "Hero"
    ]
    
    private let descriptions: [String] = [
        "This badge belongs to those who savor every bite. Rumor says it was first earned at a festival feast.",
        "Step by step, the Walker badge is proof of determination. It tells the tale of those who roam far and wide.",
        "Legends say the Hiker badge was forged on a mountain trail. Only those who push past steep climbs earn this honor.",
        "This badge is said to carry the scent of fresh meadows. Stories tell of adventurers lying in the grass, watching clouds drift by.",
        "The gleam of gold and the thrill of wealth surround this badge. Its first owner supposedly traded trinkets for treasures.",
        "A badge that glows with knowledge. Those who hold it are seasoned, their path lined with challenges overcome.",
        "Whispers tell of a hero who never left a task undone. This badge represents finishing what others only start.",
        "Tales say this badge shines brightest in the darkest hour. It is given only to those who inspire others with their deeds."
    ]
    
    private let steps: [String] = [
        "Unlock by completing 5 food-related missions.",
        "Unlock by walking 1,000 steps in total.",
        "Unlock by completing 10 walking missions.",
        "Just touch grass.",
        "Unlock by earning 100 coins.",
        "Unlock by reaching 200 XP.",
        "Unlock by completing all missions at least once.",
        "Help somebody in need."
    ]
    
    var body: some View {
        ZStack {
            // Background matches ContentView
            LinearGradient(
                gradient: Gradient(colors: [Color.yellow.opacity(0.05), Color.yellow.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Badge image
                Image(imageFiles[selectedBadge])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 6)
                
                // Badge name
                Text(names[selectedBadge])
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                // Picker card
                VStack {
                    Picker("Select Badge", selection: $selectedBadge) {
                        ForEach(0..<names.count, id: \.self) { index in
                            Text(unlockedImages[index]).tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .shadow(radius: 5)
                
                // Description + unlock requirement card
                VStack(spacing: 10) {
                    Text(descriptions[selectedBadge])
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .foregroundColor(.primary)
                    
                    Text(steps[selectedBadge])
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .shadow(radius: 4)
                
                // Complete button
                Button("🏆 Complete Achievement") {
                    imageFiles[selectedBadge] = unlockedImages[selectedBadge]
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.9))
                .foregroundColor(.blue)
                .cornerRadius(12)
                .shadow(radius: 5)
            }
            .padding()
        }
    }
}

#Preview {
    Badges()
}
