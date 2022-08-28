import AVFoundation

var audioPlayer: AVAudioPlayer?
var backgroundMusic: AVAudioPlayer?
var failMusic: AVAudioPlayer?


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

func playFail(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
      do {
        failMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        failMusic?.play()
      } catch {
        print("ERROR: Could not find and play the sound file!")
      }
    }
  }
