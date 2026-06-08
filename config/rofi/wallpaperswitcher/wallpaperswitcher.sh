#!/usr/bin/env bash
set -euo pipefail

WALLPAPERDIR="$HOME/Pictures/Wallpapers/"
THUMB_DIR="$HOME/.cache/wallpaperswitcher/"
TYPES=("scheme-tonal-spot" "scheme-monochrome" "scheme-content" "scheme-expressive" "scheme-fidelity" "scheme-fruit-salad" "scheme-neutral" "scheme-rainbow" "scheme-vibrant")
WALLPAPER_ENTRIES=""
COLOR_LIST=""
declare -A COLOR_MAP

rofi_cmd() {
    rofi -dmenu -i "$@"
}

monochrome_catpuccin_toggle() {
    local css_file="$HOME/.config/waybar/catpuccin-colors.css"

    if [[ "$1" == "true" ]]; then
        sed -i -e "s/green #a6e3a1;/green #c6c6c6;/g" \
               -e "s/yellow #f9e2af;/yellow #c6c6c6;/g" "$css_file"
    else
        sed -i -e "s/green #c6c6c6;/green #a6e3a1;/g" \
               -e "s/yellow #c6c6c6;/yellow #f9e2af;/g" "$css_file"
    fi
}

mkdir -p "$THUMB_DIR"

for wallpaper in "$WALLPAPERDIR"*; do
    wallpaper_name="${wallpaper#$WALLPAPERDIR}"
    wallpaper_no_file_ext="${wallpaper_name%.*}"
    wallpaper_undashed="${wallpaper_no_file_ext//[-]/" "}"
    each_word=( $wallpaper_undashed )
    wallpaper_capitalized="${each_word[@]^}"

    thumb_path="$THUMB_DIR/${wallpaper_name}"
    if [ ! -f "$thumb_path" ]; then
        magick "$wallpaper" -thumbnail 100x100 "$thumb_path"
    fi

    WALLPAPER_ENTRIES+="${wallpaper_capitalized}\0icon\x1f$thumb_path\n"
done

DISPLAY_SELECTION=$(echo -en "$WALLPAPER_ENTRIES" | rofi_cmd -show-icons -theme-str \
    'listview { columns: 3; lines: 2; } 
    element { orientation: vertical; border-radius: 15px; spacing: 0px; } 
    element-icon { size: 5em; } 
    element-text { horizontal-align: 0.5; }'
)

if [ -z "$DISPLAY_SELECTION" ]; then
    exit 0
fi

SELECTION=$(
    each_word=( $DISPLAY_SELECTION )
    wallpaper_lowercased="${each_word[@],,}"
    wallpaper_dashed="${wallpaper_lowercased//[ ]/-}"
    wallpaper_name="$(ls "$WALLPAPERDIR" | rg -m 1 -i "^$wallpaper_dashed\.")"
    echo "$WALLPAPERDIR$wallpaper_name"
)

DISPLAY_SCHEME_SELECTION=$(
    for type in "${TYPES[@]}"; do
        remove_beginning="${type#'scheme-'}"
        type_undashed="${remove_beginning//[-]/" "}"
        each_word=( $type_undashed )
        type_capitalized="${each_word[@]^}"
        echo -en "${type_capitalized}\n"
    done | rofi_cmd 
)

if [ "$DISPLAY_SCHEME_SELECTION" = 'Monochrome' ]; then
    monochrome_catpuccin_toggle true
    matugen image "$SELECTION" --source-color-index 0 --type scheme-monochrome
    exit 0
elif [ -z "$DISPLAY_SCHEME_SELECTION" ]; then
    exit 0
fi

SCHEME_SELECTION=$(
    each_word=( $DISPLAY_SCHEME_SELECTION )
    type_lowercased="${each_word[@],,}"
    type_dashed="${type_lowercased//[ ]/-}"
    echo "scheme-$type_dashed"
)

for i in {0..3}; do
    # 2>/dev/null hides the error text
    hex=$(matugen image "$SELECTION" -j hex --dry-run --source-color-index "$i" 2>/dev/null | jq -r '.colors.primary.default.color' || true)
    
    if [ "$hex" != "null" ] && [ -n "$hex" ]; then
        COLOR_MAP["$hex"]="$i"
        COLOR_LIST+="<span color='$hex'></span>\n"
    fi
done

if [ "${#COLOR_MAP[@]}" -eq 1 ]; then
    monochrome_catpuccin_toggle false
    matugen image "$SELECTION" --source-color-index 0 --type "$SCHEME_SELECTION"
    exit 0
fi

COLOR_LIST="${COLOR_LIST%\\n}"

CHOSEN=$(echo -e "$COLOR_LIST" | rofi_cmd -markup-rows -theme-str \
    '* { font: "JetBrainsMono Nerd Font Propo 19.5"; }
    window { width: 8.80em; }
    listview { columns: 4; lines: 1; } 
    element { orientation: vertical; spacing: 0px; }
    inputbar { enabled: false; }'
)

if [ -z "$CHOSEN" ]; then
    exit 0
fi

CHOSEN_INDEX=$(
    extracted_hex="${CHOSEN#*color=\'}"
    extracted_hex="${extracted_hex%\'>*}"
    echo "${COLOR_MAP[$extracted_hex]}"
)

monochrome_catpuccin_toggle false
matugen image "$SELECTION" --source-color-index "$CHOSEN_INDEX" --type "$SCHEME_SELECTION"
