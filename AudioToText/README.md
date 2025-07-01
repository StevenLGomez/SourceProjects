
Placeholder


1. Whisper by OpenAI (via Whisper.cpp or PyWhisper)

sudo apt install -y python3-pip
pip install -U openai-whisper  # <-- Takes a really long time!

whisper your-audio-file.mp3 --model medium --language English


There are several Free and Open Source Software (FOSS) tools that can convert audio files to text on **Ubuntu** or **Red Hat** (RHEL/CentOS/Fedora). Since you're focusing on **non-real-time transcription**, you have more flexibility with tools that focus on accuracy over speed. Here are the most relevant options:

---

### ✅ 1. **Whisper by OpenAI (via Whisper.cpp or PyWhisper)**

* **License:** MIT
* **Languages:** Many (supports multilingual transcription)
* **Offline:** Yes (with Whisper.cpp or Whisper Python)
* **Accuracy:** Very high for English and decent for many other languages
* **Real-time:** No (but fast enough for post-processing)
* **GPU Support:** Optional (CPU works too, slower)

#### 🔧 Installation (Python version):

```bash
pip install -U openai-whisper
```

Then transcribe:

```bash
whisper your-audio-file.mp3 --model medium --language English
```

#### 🔧 Installation (C++ version – faster, lighter):

```bash
git clone https://github.com/ggerganov/whisper.cpp
cd whisper.cpp
make
./main -m models/ggml-medium.en.bin -f your-audio-file.wav
```

---

Step 1: Install Whisper & ffmpeg
pip install -U openai-whisper
sudo apt install ffmpeg  # or sudo dnf install ffmpeg on Red Hat

Step 2: Save this script as transcribe_audio.py
import os
import sys
import subprocess
import whisper

def convert_to_wav(input_file, output_file):
    """Convert audio to 16kHz mono WAV for Whisper compatibility (optional)"""
    cmd = [
        "ffmpeg", "-y", "-i", input_file,
        "-ar", "16000", "-ac", "1", output_file
    ]
    subprocess.run(cmd, check=True)

def transcribe_audio(file_path, model_size="medium"):
    model = whisper.load_model(model_size)
    result = model.transcribe(file_path)
    return result["text"]

def main():
    if len(sys.argv) < 2:
        print("Usage: python transcribe_audio.py <audiofile>")
        sys.exit(1)

    input_file = sys.argv[1]

    if not os.path.exists(input_file):
        print(f"File not found: {input_file}")
        sys.exit(1)

    base_name = os.path.splitext(os.path.basename(input_file))[0]
    temp_wav = f"{base_name}_converted.wav"
    output_txt = f"{base_name}_transcript.txt"

    # Optional: Convert to WAV for better compatibility
    print("Converting audio...")
    convert_to_wav(input_file, temp_wav)

    print("Transcribing...")
    transcript = transcribe_audio(temp_wav)

    with open(output_txt, "w") as f:
        f.write(transcript)

    print(f"✅ Transcription saved to {output_txt}")
    os.remove(temp_wav)

if __name__ == "__main__":
    main()

Step 3: Run the script:
python3 transcribe_audio.py meeting_recording.mp3

Output will be saved as meeting_recording_transcript.txt

Script ran out of memory as written above.
Solution Options

1. Use a smaller Whisper model
Change the model_size from "medium" to "base" or "small" in the script:
transcribe_audio(temp_wav, model_size="base")
OR
Change this line in the script:
def transcribe_audio(file_path, model_size="base"): // Applied this change

Model sizes and approximate RAM needs:
Model	RAM Needed	Speed	Accuracy
tiny	~1 GB	⚡⚡⚡	🟡
base	~1.5 GB	⚡⚡	🟡🟡
small	~2.5 GB	⚡	🟡🟡🟡
medium	~5–6 GB	🐢	🟢🟢🟢

2. Switch to Whisper.cpp (Much Lower Memory Use)

If your system is RAM-limited (e.g., <8 GB), whisper.cpp is a C++ port that’s highly efficient on CPU.
🛠 Install:

git clone https://github.com/ggerganov/whisper.cpp
cd whisper.cpp
make

Download a small model:

./models/download-ggml-model.sh base.en

Transcribe:

./main -m models/ggml-base.en.bin -f yourfile.wav -otxt

This generates yourfile.wav.txt.

    Use -m models/ggml-small.en.bin for better accuracy if RAM allows.

🧪 Optional: Monitor Memory Usage

To confirm RAM is the issue:

htop

Then rerun your script and watch memory. If it spikes near your system's max before the process is killed, that confirms it.


### ✅ 2. **Vosk**

* **License:** Apache 2.0
* **Languages:** Multiple (supports models for English, Spanish, German, etc.)
* **Offline:** Yes
* **Real-time:** Possible, but supports post-processing
* **Platform:** Python, Java, C++, Node.js

#### 🔧 Installation (Python):

```bash
pip install vosk
```

#### Example script:

```python
from vosk import Model, KaldiRecognizer
import wave
import json

wf = wave.open("your-audio-file.wav", "rb")
model = Model("model")
rec = KaldiRecognizer(model, wf.getframerate())

while True:
    data = wf.readframes(4000)
    if len(data) == 0:
        break
    if rec.AcceptWaveform(data):
        print(rec.Result())

print(rec.FinalResult())
```

> ⚠️ Convert audio to WAV 16KHz mono beforehand:

```bash
ffmpeg -i yourfile.mp3 -ar 16000 -ac 1 yourfile.wav
```

---

### ✅ 3. **Mozilla DeepSpeech** (now community-maintained)

* **License:** MPL 2.0
* **Offline:** Yes
* **Languages:** Primarily English
* **Accuracy:** Lower than Whisper, but still usable

#### Installation:

```bash
pip install deepspeech
```

#### Use:

```bash
deepspeech --model deepspeech.pbmm --scorer deepspeech.scorer --audio your-audio.wav
```

> ⚠️ Must pre-convert audio to 16kHz mono WAV:

```bash
ffmpeg -i input.mp3 -ar 16000 -ac 1 output.wav
```

---

## 🔍 Recommendation

| Tool                        | Accuracy | Speed               | Offline | Multilingual       | Ease of Use | Notes                                |
| --------------------------- | -------- | ------------------- | ------- | ------------------ | ----------- | ------------------------------------ |
| **Whisper** (Python or C++) | ⭐⭐⭐⭐     | ⚡ (with GPU or C++) | ✅       | ✅                  | 👍👍        | Best overall, active development     |
| **Vosk**                    | ⭐⭐⭐      | ⚡⚡                  | ✅       | ✅                  | 👍          | Lightweight, good community support  |
| **DeepSpeech**              | ⭐⭐       | ⚡                   | ✅       | ❌ (mostly English) | 👍          | Legacy, mostly superseded by Whisper |

---

Would you like a script that automatically converts an MP3 or WAV file to text using one of these tools?





flatpak install flathub net.mkiol.SpeechNote

Notes with offline Speech to Text, Text to Speech and Machine Translation

Speech Note let you take, read and translate notes in multiple languages. It uses Speech to Text, Text to Speech and Machine Translation to do so. Text and voice processing take place entirely offline, locally on your computer, without using a network connection. Your privacy is always respected. No data is sent to the Internet.

Changes in version 4.8.0 - 7 days ago (Built 5 days ago)

General:

    Case-sensitive matching in 'Rules'. To enable case-sensitive matching in text, use the option 'Case sensitive' in the rule editing form.

User Interface:

    Speech Note has been translated into Arabic, Catalan, Spanish, Turkish and French-Canadian languages.
    Command line option and DBus API for exporting synthesized speech to an audio file instead of playing it aloud.

Speech to Text:

    New 'CrisperWhisper' model for 'FasterWhisper' engine. CrisperWhisper is designed for fast, precise, and verbatim speech recognition with accurate word-level timestamps. Unlike the original Whisper, which tends to omit disfluencies and follows more of a intended transcription style, CrisperWhisper aims to transcribe every spoken word exactly as it is, including fillers, pauses, stutters and false starts. CrisperWhisper model is enabled only for English and German languages.
    'KBLab Whisper' models for Swedish. The National Library of Sweden has released fine-tuned STT models trained on its library collections. The models have significantly improved accuracy compared to regular Whisper models. Even "Tiny" model provides decent quality. KBLab models are available as both 'FasterWhisper' and 'WhisperCpp'.
    Using an existing note as the initial context in decoding. This has the potential to improve transcription quality and reduce 'hallucination' problem. If you observe a degradation in quality, turn off the 'Use note as context' option.
    Option to pause listening while processing. This option can be useful when 'Listening mode' is 'Always on'. By default, listening continues even when a piece of audio data is being processed. Using this option, you can temporarily pause listening for the duration of processing.
    Option to play an audible tone when starting and stopping listening

Text to Speech:

    Kokoro TTS engine. Kokoro is a compact yet powerful open-source multilingual TTS engine. Despite its modest size (trained on less than 100 hours of audio), it delivers impressive results. Unlike other engines with comparable quality, Kokoro offers the advantage of running even on devices without GPUs. Kokoro voices are enabled for: English, Chinese, Japanese, Hindi, Italian, French, Spanish and Portuguese.
    F5-TTS engine. The F5-TTS provides exceptional voice cloning capabilities. The currently enabled model works with English and Chinese languages.
    Parler TTS engine. Parler TTS can generate high-quality, natural sounding speech in the style of a given speaker (gender, pitch, speaking style, etc). The speaker's characteristics are defined by a text description (prompt). Parler TTS primarily supports English, but a multilingual model for French, Spanish, Portuguese, Polish, German, Dutch and Italian is also included.
    S.A.M. TTS engine. S.A.M. is a small speech synthesizer designed for the Commodore 64. It features a robotic voice that evokes a strong sense of nostalgia. The S.A.M. voice is available in English only.
    'Normalize audio' setting option. Use this option to enable/disable audio volume normalization.
    New 'Piper' voices for Dutch, Finnish, German and Luxembourgish
    New 'RHVoice' voice for Spanish
    Updated 'RHVoice' voice for Czech

Translator:

    New models: English to Chinese, English to Arabic, Arabic to English, English to Korean, English to Japanese

Accessibility:

    Support for 'Insert into active window' under Wayland. Using 'start-listening-active-window' or 'start-listening-translate-active-window' actions you can directly insert the decoded text into any window which is currently in focus. This feature worked under X11 only but now it is also suppored under Wayland. For actions to work, 'ydotool' daemon must be installed and running.
    Support for 'Global keyboard shortcuts' under Wayland. Until now, this capability was only available under X11. Now integration with 'XDG Desktop Portal' has been added, making global keyboard shortcuts possible also under Wayland. For shortcuts to work, your desktop enviroment has to support 'GlobalShortcuts' interface on 'XDG Desktop Portal' service.

Flatpak:

    Python support enabled in 'Tiny' or ARM packages. Python libraries are not included in Tiny or ARM packages, but using the 'Location of Python libraries' option, you can set an external directory that contains the libraries.
    Flatpak runtime update to version 5.15-24.08


