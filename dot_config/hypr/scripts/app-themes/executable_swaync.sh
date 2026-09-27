#!/bin/bash

if command -v swaync-client &>/dev/null; then
    swaync-client -R
    swaync-client -rs
fi