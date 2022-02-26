#!/bin/sh

# build the app for wasm
cargo build --release --target wasm32-unknown-unknown

# Create binding files...
wasm-bindgen --out-dir ./out/ --target web target/wasm32-unknown-unknown/release/my_bevy_game.wasm
