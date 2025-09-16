import SwiftUI

// MARK: - Data Model
struct Mission: Identifiable {
    let id = UUID()
    let description: String
    let coinsReward: Int
    let xpReward: Int
}

// MARK: - ViewModel
class MissionViewModel: ObservableObject {
    @Published var currentMission: Mission?
    @Published var showReward = false
    
    let missions: [Mission] = [
        Mission(description: "Walk 500 steps", coinsReward: 10, xpReward: 0),
        Mission(description: "Drink 2 glasses of water", coinsReward: 0, xpReward: 5),
        Mission(description: "Do 5 pushups", coinsReward: 15, xpReward: 0),
        Mission(description: "Read for 10 minutes", coinsReward: 0, xpReward: 20),
        Mission(description: "Stretch for 2 minutes", coinsReward: 5, xpReward: 0)
    ]
    
    func generateMission() {
        currentMission = missions.randomElement()
        showReward = false
    }
    
    func completeMission() {
        showReward = true
    }
}

// MARK: - View
struct Quest_page: View {
    @State private var coins: Int = 0
    @State private var XP: Int = 0
    @StateObject private var viewModel = MissionViewModel()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.6), Color.teal.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("🎯 Missions")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)
                    .padding(.top, 60) // space below HUD
                
                // Mission card
                if let mission = viewModel.currentMission {
                    VStack(spacing: 12) {
                        Text("Mission:")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        Text(mission.description)
                            .font(.title3)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            .shadow(radius: 3)
                        
                        if viewModel.showReward {
                            Text("✅ Reward: \(mission.coinsReward) Coins, \(mission.xpReward) XP")
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                } else {
                    Text("Tap the button to generate a mission!")
                        .foregroundColor(.secondary)
                        .padding()
                }
                
                Spacer()
                
                // Buttons
                VStack(spacing: 12) {
                    Button("🎲 New Mission") {
                        viewModel.generateMission()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    
                    if let mission = viewModel.currentMission, !viewModel.showReward {
                        Button("✅ Complete") {
                            viewModel.completeMission()
                            coins += mission.coinsReward
                            XP += mission.xpReward
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding()
            
            // HUD - Coins & XP in top right
            HStack(spacing: 10) {
                Label("\(coins)", systemImage: "bitcoinsign.circle.fill")
                    .font(.subheadline.bold())
                    .padding(6)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                
                Label("\(XP)", systemImage: "sparkles")
                    .font(.subheadline.bold())
                    .padding(6)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
            }
            .padding()
        }
    }
}

#Preview {
    Quest_page()
}
