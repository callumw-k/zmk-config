#/bin/bash

QUICK=false
for arg in "$@"; do
    if [ "$arg" == "--quick" ]; then
        QUICK=true
        echo "Quick mode enabled: Skipping git pull, Docker stop/rm, and west update."
    fi
done

for dir in ./modules/*/; do
    # Check if the directory is a Git repository
    if [ -d "$dir/.git" ]; then
        echo "Updating repository in $dir"
        # Navigate to the repository directory and pull the latest changes
        git -C "$dir" pull
    else
        echo "Skipping $dir — not a Git repository."
    fi
done

docker compose up -d --build




echo "Building the application inside container"

docker exec zmk-build-container bash -c '
    cd app/ && \
    west build -b nice_nano_v2 -- \
    -DSHIELD=corne_left \
    -DZMK_EXTRA_MODULES="/workspaces/zmk/zmk-modules/zmk-helpers;/workspaces/zmk/zmk-modules/zmk-tri-state" \
    -DZMK_CONFIG=/workspaces/zmk/zmk-config
'

cp ./build/zmk.uf2 .

docker container stop zmk-build-container
docker container rm zmk-build-container

# west build -b nice_nano_v2 -- -DSHIELD=vendor_shield -DZMK_EXTRA_MODULES="/workspaces/zmk/zmk-modules/zmk-helpers;/workspaces/zmk/zmk-modules/zmk-tri-state" -DZMK_CONFIG=/workspaces/zmk/zmk-config
