#!/bin/bash
# Install the whisper server as a launchd agent, then check it.
set -e
cd "$(dirname "$0")"

model=~/.cache/whisper.cpp/ggml-large-v3-turbo.bin
plist=~/Library/LaunchAgents/com.kbrock.whisper-server.plist

mkdir -p ~/.cache/whisper.cpp
[ -f "$model" ] || curl -L -o "$model" \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo.bin

cp com.kbrock.whisper-server.plist "$plist"
launchctl bootout "gui/$(id -u)/com.kbrock.whisper-server" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$plist"

# Check: speak a test phrase, upload it, print the transcript.
host=${1:-Studio.local}
say -o /tmp/whisper-check.aiff "testing one two three"
until curl -s -o /dev/null "http://$host:9940/"; do sleep 1; done
curl -s "http://$host:9940/v1/audio/transcriptions" \
  -F file=@/tmp/whisper-check.aiff -F model=whisper-1 -F response_format=json
echo
