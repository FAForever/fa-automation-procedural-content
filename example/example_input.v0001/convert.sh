#!/bin/bash

# Variables used throughout the script
# -----------------------------------------------------------------------------

target="../example.v0001/"

# resolutionMask=256          # 5x5
# resolutionMask=512          # 10x10
resolutionMask=1024 # 20x20

# resolutionHeightmap=257     # 5x5
# resolutionHeightmap=513     # 10x10
resolutionHeightmap=1025 # 20x20

function MkDir() {
    if [ ! -d "$1" ]; then
        mkdir "$1"
        echo "Created folder: $1"
    fi
}

# Create the expected file hierarchy if it is missing
# -----------------------------------------------------------------------------

MkDir "input-masks"
MkDir "input-heightmaps"

# non-procedurally generated images
MkDir "convert-decals"
MkDir "convert-strata"
MkDir "convert-masks"
MkDir "convert-heightmaps"

# procedurally generated images
MkDir "procedural-decals"
MkDir "procedural-strata"
MkDir "procedural-masks"
MkDir "procedural-heightmaps"

MkDir "procedural"

MkDir "$target/env"
MkDir "$target/env/decals"
MkDir "$target/env/layers"
MkDir "$target/masks"
MkDir "$target/heightmaps"

# Convert masks
# -----------------------------------------------------------------------------

if [ -z "$(ls -A "procedural-masks")" ]; then
    echo "There are no procedural masks to convert: the folder is empty."
else
    for entry in "procedural-masks/"*; do
        # determine new file location
        fileWithoutExtension="${entry%.*}"
        fileNew=$(basename $fileWithoutExtension)
        rawNew="$target/masks/$fileNew.raw"

        # only change if file we want to convert is newer
        if [[ "$entry" -nt "$rawNew" ]] || [ ! -f "$rawNew" ]; then
            # convert the file
            echo "Processing: $entry"
            magick convert "$entry" -resize "${resolutionMask}x${resolutionMask}" "$fileWithoutExtension-resized.png"
            magick convert "$fileWithoutExtension-resized.png" -depth 8 "$fileWithoutExtension-resized.gray"

            # move it to the new location
            rm "$fileWithoutExtension-resized.png"
            mv "$fileWithoutExtension-resized.gray" "$rawNew"
        else
            echo "Skipping: $entry (not updated)"
        fi
    done
fi

if [ -z "$(ls -A "convert-masks")" ]; then
    echo "There are no non-procedural masks to convert: the folder is empty."
else
    for entry in "convert-masks/"*; do
        # determine new file location
        fileWithoutExtension="${entry%.*}"
        fileNew=$(basename $fileWithoutExtension)
        rawNew="$target/masks/$fileNew.raw"

        # only change if file we want to convert is newer
        if [[ "$entry" -nt "$rawNew" ]] || [ ! -f "$rawNew" ]; then
            # convert the file
            echo "Processing: $entry"
            magick convert "$entry" -resize "${resolutionMask}x${resolutionMask}" "$fileWithoutExtension-resized.png"
            magick convert "$fileWithoutExtension-resized.png" -depth 8 "$fileWithoutExtension-resized.gray"

            # move it to the new location
            rm "$fileWithoutExtension-resized.png"
            mv "$fileWithoutExtension-resized.gray" "$rawNew"
        else
            echo "Skipping: $entry (not updated)"
        fi
    done
fi

# Convert heightmaps
# -----------------------------------------------------------------------------

if [ -z "$(ls -A "procedural-heightmaps")" ]; then
    echo "There are no procedural heightmaps to convert: the folder is empty."
else
    for entry in "procedural-heightmaps/"*; do
        # determine new file location
        fileWithoutExtension="${entry%.*}"
        fileNew=$(basename $fileWithoutExtension)
        rawNew="$target/heightmaps/$fileNew.raw"

        # only change if file we want to convert is newer
        if [[ "$entry" -nt "$rawNew" ]] || [ ! -f "$rawNew" ]; then
            # convert the file
            echo "Processing: $entry"
            magick convert "$entry" -resize "${resolutionHeightmap}x${resolutionHeightmap}" "$fileWithoutExtension-resized.png"
            magick convert "$fileWithoutExtension-resized.png" -depth 16 "$fileWithoutExtension-resized.gray"

            # move it to the new location
            rm "$fileWithoutExtension-resized.png"
            mv "$fileWithoutExtension-resized.gray" "$rawNew"
        else
            echo "Skipping: $entry (not updated)"
        fi
    done
fi

if [ -z "$(ls -A "convert-heightmaps")" ]; then
    echo "There are no non-procedural heightmaps to convert: the folder is empty."
else
    for entry in "convert-heightmaps/"*; do
        # determine new file location
        fileWithoutExtension="${entry%.*}"
        fileNew=$(basename $fileWithoutExtension)
        rawNew="$target/heightmaps/$fileNew.raw"

        # only change if file we want to convert is newer
        if [[ "$entry" -nt "$rawNew" ]] || [ ! -f "$rawNew" ]; then
            # convert the file
            echo "Processing: $entry"
            magick convert "$entry" -resize "${resolutionHeightmap}x${resolutionHeightmap}" "$fileWithoutExtension-resized.png"
            magick convert "$fileWithoutExtension-resized.png" -depth 16 "$fileWithoutExtension-resized.gray"

            # move it to the new location
            rm "$fileWithoutExtension-resized.png"
            mv "$fileWithoutExtension-resized.gray" "$rawNew"
        else
            echo "Skipping: $entry (not updated)"
        fi
    done
fi

# Convert decals
# -----------------------------------------------------------------------------

if [ -z "$(ls -A "procedural-decals")" ]; then
    echo "There are no procedural decals to convert: the folder is empty."
else
    for entry in "procedural-decals/"*; do
        # determine old file location
        fileOld="${entry%.*}"
        ddsOld="$fileOld.dds"

        # determine new file location
        fileNew=$(basename $fileOld)
        ddsNew="$target/env/decals/$fileNew.dds"

        # only change if file we want to convert is newer
        if [[ "$entry" -nt "$ddsNew" ]] || [ ! -f "$ddsNew" ]; then
            # convert the file
            echo "Processing: $entry"
            magick "$entry" -define dds:compression=dxt5 "$ddsOld"

            # move it to the new location
            mv "$ddsOld" "$ddsNew"
        else
            echo "Skipping: $entry (not updated)"
        fi
    done
fi

if [ -z "$(ls -A "convert-decals")" ]; then
    echo "There are no non-procedural decals to convert: the folder is empty."
else
    for entry in "convert-decals/"*; do
        # determine old file location
        fileOld="${entry%.*}"
        ddsOld="$fileOld.dds"

        # determine new file location
        fileNew=$(basename $fileOld)
        ddsNew="$target/env/decals/$fileNew.dds"

        # only change if file we want to convert is newer
        if [[ "$entry" -nt "$ddsNew" ]] || [ ! -f "$ddsNew" ]; then
            # convert the file
            echo "Processing: $entry"
            magick "$entry" -define dds:compression=dxt5 "$ddsOld"

            # move it to the new location
            mv "$ddsOld" "$ddsNew"
        else
            echo "Skipping: $entry (not updated)"
        fi
    done
fi

# Convert stratum textures
# -----------------------------------------------------------------------------

if [ -z "$(ls -A "procedural-strata")" ]; then
    echo "There are no procedural strata to convert: the folder is empty."
else
    for entry in "procedural-strata/"*; do
        # determine old file location
        fileOld="${entry%.*}"
        ddsOld="$fileOld.dds"

        # determine new file location
        fileNew=$(basename $fileOld)
        ddsNew="$target/env/layers/$fileNew.dds"

        # only change if file we want to convert is newer
        if [[ "$entry" -nt "$ddsNew" ]] || [ ! -f "$ddsNew" ]; then
            # convert the file
            echo "Processing: $entry"
            magick "$entry" -define dds:compression=dxt5 "$ddsOld"

            # move it to the new location
            mv "$ddsOld" "$ddsNew"
        else
            echo "Skipping: $entry (not updated)"
        fi
    done
fi

if [ -z "$(ls -A "convert-strata")" ]; then
    echo "There are no non-procedural strata to convert: the folder is empty."
else
    for entry in "convert-strata/"*; do
        # determine old file location
        fileOld="${entry%.*}"
        ddsOld="$fileOld.dds"

        # determine new file location
        fileNew=$(basename $fileOld)
        ddsNew="$target/env/layers/$fileNew.dds"

        # only change if file we want to convert is newer
        if [[ "$entry" -nt "$ddsNew" ]] || [ ! -f "$ddsNew" ]; then
            # convert the file
            echo "Processing: $entry"
            magick "$entry" -define dds:compression=dxt5 "$ddsOld"

            # move it to the new location
            mv "$ddsOld" "$ddsNew"
        else
            echo "Skipping: $entry (not updated)"
        fi
    done
fi

# Allow the user to read the console output
read -p "Press Enter to exit..."
