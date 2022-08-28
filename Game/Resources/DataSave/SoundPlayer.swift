import AVFoundation

var audioPlayer: AVAudioPlayer?
var backgroundMusic: AVAudioPlayer?

func playSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
      print("ERROR: Could not find and play the sound file!")
    }
  }
}



func playBackground(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      backgroundMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      backgroundMusic?.play()
    } catch {
      print("ERROR: Could not find and play the sound file!")
    }
  }
}
