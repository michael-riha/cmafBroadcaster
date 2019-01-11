#!/bin/bash
echo "starting the server now! ($STREAM)"
echo "OUTPUT @-> $OUTPUT_FOLDER"

# https://stackoverflow.com/questions/59838/check-if-a-directory-exists-in-a-shell-script
if [ ! -d "$OUTPUT_FOLDER" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo "have to create ouput folder!"
  sudo mkdir $OUTPUT_FOLDER
  sudo chown wsgi:wsgi -R $OUTPUT_FOLDER
  sudo chmod g+rw -R $OUTPUT_FOLDER
  ls -la $OUTPUT_FOLDER
fi

#start a teststream https://unix.stackexchange.com/questions/222847/how-to-stream-with-ffmpeg-in-a-separate-process
#./launchEncoderTestPattern.sh > /out/output.log 2>&1 < /dev/null &
#/tmp/launchEncoderTestPattern.sh > /out/output.log 2>&1 < /dev/null &
#/tmp/launchEncoderTestPattern_withAudio.sh > /out/output.log 2>&1 < /dev/null &

case "$STREAM" in
"with_audio")
    echo "starting stream with audio"
    /tmp/launchEncoderTestPattern_withAudio.sh > /out/output.log 2>&1 < /dev/null &
    ;;
*)
    echo "starting stream without audio"
    /tmp/launchEncoderTestPattern.sh > /out/output.log 2>&1 < /dev/null &
    ;;
esac

mod_wsgi-express start-server --chunked-request --url-alias /static $OUTPUT_FOLDER --include-file srv/conf/extra.conf /srv/wsgi-scripts/wc_config_handler.py
