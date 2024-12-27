#!/bin/bash

# Universal Video Downloader using yt-dlp

# ASCII Art Menu
menu() {
    echo "╔═╦══╦═╦═╦╗╔══╗"
    echo "║╔╩╗╔╣║║║║║║══╣"
    echo "║╚╗║║║║║║║╚╬══║"
    echo "╚═╝╚╝╚═╩═╩═╩══╝"
    echo "             by Carl James Valdez"
    echo ""
    echo "Universal Video Downloader"
    echo "|=========================|"
    echo "Options:"
    echo "  -f, --format FORMAT      Specify video format (default: best)"
    echo "  -o, --output OUTPUT      Specify output filename"
    echo "  -a, --audio-only         Download audio only"
    echo "  -h, --help               Display this help message"
    echo ""
}

# Function to display usage
usage() {
    menu
    echo "Usage: $0 [OPTIONS] URL"
    exit 1
}

# Default values
FORMAT="best"
OUTPUT=""
AUDIO_ONLY=false

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -f|--format)
            FORMAT="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT="$2"
            shift 2
            ;;
        -a|--audio-only)
            AUDIO_ONLY=true
            shift
            ;;
        -h|--help)
            menu
            usage
            ;;
        *)
            URL="$1"
            shift
            ;;
    esac
done

# Check if URL is provided
if [[ -z "$URL" ]]; then
    echo "Error: No URL provided."
    usage
fi

# Display menu
menu

# Construct yt-dlp command
CMD="yt-dlp"
if [[ "$AUDIO_ONLY" = true ]]; then
    CMD+=" --extract-audio --audio-format mp3"
fi
CMD+=" -f $FORMAT"
if [[ -n "$OUTPUT" ]]; then
    CMD+=" -o \"$OUTPUT\""
fi
CMD+=" \"$URL\""

# Execute the command
echo "Executing: $CMD"
eval $CMD