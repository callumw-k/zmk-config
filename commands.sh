#/bin/bash

docker compose build
docker compose up -d

echo "Building the application inside container"

docker exec zmk-build-container bash -c '
    cd zmk/app/ && \
    west build -d build/left -b nice_nano_v2 -- \
    -DSHIELD=corne_left \
    -DZMK_CONFIG=/workspaces/zmk/config \
    -DZephyr_DIR=/workspaces/zmk/zephyr/share/zephyr-package/cmake
' &
LEFT_PID=$!

docker exec zmk-build-container bash -c '
    cd zmk/app/ && \
    west build -d build/right -p -b nice_nano_v2 -- \
    -DSHIELD=corne_right \
    -DZMK_CONFIG=/workspaces/zmk/config \
    -DZephyr_DIR=/workspaces/zmk/zephyr/share/zephyr-package/cmake
' &
RIGHT_PID=$!

wait $LEFT_PID
LEFT_STATUS=$?
wait $RIGHT_PID
RIGHT_STATUS=$?

if [ $LEFT_STATUS -ne 0 ] || [ $RIGHT_STATUS -ne 0 ]; then
    echo "Build failed (left: $LEFT_STATUS, right: $RIGHT_STATUS)"
    docker container rm -f zmk-build-container
    exit 1
fi

docker cp zmk-build-container:/workspaces/zmk/zmk/app/build/left/zephyr/zmk.uf2 ./zmk_left.uf2
docker cp zmk-build-container:/workspaces/zmk/zmk/app/build/right/zephyr/zmk.uf2 ./zmk_right.uf2

docker container rm -f zmk-build-container
