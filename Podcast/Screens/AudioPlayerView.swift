//
//  AudioPlayerView.swift
//  Podcast
//
//  Created by Raidan on 03/08/2024.
//
//
//
import SwiftUI
import AVKit

struct AudioPlayerView: View {
    @StateObject var viewModel: AudioPlayerViewModel
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    ModifiedButtonView(image: "arrow.left")
                    Spacer()
                    ModifiedButtonView(image: "line.horizontal.3.decrease")
                }
                
                Text("Now Playing")
                    .fontWeight(.bold)
                    .foregroundColor(.black.opacity(0.8))
            }
            .padding(.all)
            
            Image("tree")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 55)
                .clipShape(Circle())
                .padding(.all, 8)
                .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.35), radius: 8, x: 8, y: 8)
                .shadow(color: Color.white, radius: 10, x: -10, y: -10)
                .padding(.top, 35)
            
            Text("Drift")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 25)
            
            Text("Robot Koch ft. nilu")
                .font(.caption)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 2)
            
            VStack {
                HStack {
                    Text(timeString(time: viewModel.currentTime))
                    Spacer()
                    Text(timeString(time: viewModel.totalTime))
                }
                .font(.caption)
                .foregroundColor(.black.opacity(0.8))
                .padding([.top, .trailing, .leading], 20)
                
                Slider(value: Binding(get: {
                    viewModel.currentTime
                }, set: { newValue in
                    viewModel.seekToTime(newValue)
                }), in: 0...viewModel.totalTime)
                .padding([.top, .trailing, .leading], 20)
            }
            
            HStack(spacing: 20) {
                Button(action: {}, label: {
                    ModifiedButtonView(image: "backward.fill")
                })
                
                Button {
                    viewModel.isPlaying ? viewModel.pauseAudio() : viewModel.playAudio()
                } label: {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 14, weight: .bold))
                        .padding(.all, 25)
                        .foregroundColor(.black.opacity(0.8))
                        .background(
                            ZStack {
                                Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                                
                                Circle()
                                    .foregroundColor(.white)
                                    .blur(radius: 4)
                                    .offset(x: -8, y: -8)
                                
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8980392157, green: 0.933333333, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .padding(2)
                                    .blur(radius: 2)
                            }
                                .clipShape(Circle())
                                .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                                .shadow(color: Color.white, radius: 20, x: -20, y: -20))
                }
                
                Button(action: {}, label: {
                    ModifiedButtonView(image: "forward.fill")
                })
            }
            .padding(.top, 25)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
}

struct ModifiedButtonView: View {
    var image: String
    
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: image)
                .font(.system(size: 14, weight: .bold))
                .padding(.all, 25)
                .foregroundColor(.black.opacity(0.8))
                .background(
                    ZStack {
                        Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                        
                        Circle()
                            .foregroundColor(.white)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8980392157, green: 0.933333333, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(2)
                            .blur(radius: 2)
                    }
                        .clipShape(Circle())
                        .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                        .shadow(color: Color.white, radius: 20, x: -20, y: -20)
                )
        })
    }
}

#Preview {
    AudioPlayerView(viewModel: AudioPlayerViewModel(audioFile: "https://example.com/audio.mp3"))
}
