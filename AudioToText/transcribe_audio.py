
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

def transcribe_audio(file_path, model_size="small"):
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

