#/bin/bash

QUICK=false
for arg in "$@"; do
    if [ "$arg" == "--quick" ]; then
        QUICK=true
        echo "Quick mode enabled: Skipping git pull, Docker stop/rm, and west update."
    fi
done

if [ "$QUICK" = false ]; then
    # Update Git repositories
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

    # Stop and remove the Docker container
    docker container stop zmk-build-container
    docker container rm zmk-build-container
    docker compose up -d --build
else 
    docker compose up -d
fi




# file_exists_in_container() {
#     docker exec zmk-build-container test -f "$1"
# }
#
# if file_exists_in_container /workspaces/zmk/.west/config; then
#     echo "Config exists inside container, skipping 'west init'"
# else
#     echo "Running 'west init -l app/' inside container"
#     docker exec zmk-build-container west init -l app/
# fi

# if [ "$QUICK" = false ]; then
#     echo "Running 'west update' inside container"
#     docker exec zmk-build-container west update
# else
#     echo "Skipping 'west update'"
# fi

echo "Building the application inside container"
docker exec zmk-build-container bash -c '
    cd app/ && \
    west build -b nice_nano_v2 -- \
    -DSHIELD=corne_left \
    -DZMK_EXTRA_MODULES="/workspaces/zmk/zmk-modules/zmk-helpers;/workspaces/zmk/zmk-modules/zmk-tri-state" \
    -DZMK_CONFIG=/workspaces/zmk/zmk-config
'

cp ./build/zmk.uf2 .

# west build -b nice_nano_v2 -- -DSHIELD=vendor_shield -DZMK_EXTRA_MODULES="/workspaces/zmk/zmk-modules/zmk-helpers;/workspaces/zmk/zmk-modules/zmk-tri-state" -DZMK_CONFIG=/workspaces/zmk/zmk-config
