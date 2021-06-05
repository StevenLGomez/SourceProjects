
# flac-to-mp3.sh
#
# Requires lame & flac  

# Move MP3 files directly onto USB device
for f in *.mp3;
    do
        echo ''
        echo Moving $f 
        mv *.mp3 /media/gomez/BLACKBERRY/
    done

for f in *.flac; 
    do 
        echo ''
        echo Converting $f 
        flac -cd "$f" | lame -b 320 - /media/gomez/BLACKBERRY/"${f%.*}".mp3; 
        rm "$f"
    done

