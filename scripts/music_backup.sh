
# Rsync command to backup SqueezeBox Server to locally attached USB drive.
# NOTE - There is not a trailing slash after /media/MusicCollection, therefore the <volume name>/MusicCollection
#        directory will be used instead of creating it.
sudo rsync --progress --archive --delete --recursive --compress admin@apollo:/media/MusicCollection /media/gomez/<volume name>

