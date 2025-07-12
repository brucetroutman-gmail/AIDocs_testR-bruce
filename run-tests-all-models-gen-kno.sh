#!/bin/bash

function testit(){
    export SEARCH_MODEL="$1"
    ait s11 t011
}

    testit "qwen2:1.5b"             # 0.934 GB
    testit "gemma3:1b-it-q4_K_M"    # 0.815 GB
    testit "granite3.3:2b"          # 1.5 GB
    testit "llama3.2:3b"            # 2.0 GB
    testit "phi4-mini:3.8b-q4_K_M"  # 2.5 GB
