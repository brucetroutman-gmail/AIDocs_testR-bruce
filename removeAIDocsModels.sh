#!/bin/bash

# Function to check if Ollama is installed
check_ollama_installed() {
    if ! command -v ollama &> /dev/null; then
        echo "❌ Ollama is not installed on this system."
        echo "Please install Ollama from https://ollama.com before running this script."
        exit 1
    else
        echo "✅ Ollama is installed."
    fi
}

# Function to remove a model (whether it's already installed or not)
rm_model() {
    local model=$1
    
    echo "🔄 Removing model: $model"
    ollama rm $model
    if [ $? -eq 0 ]; then
        echo "✅ Successfully Removed $model."
    else
        echo "❌ Failed to remove $model."
    fi
    echo "----------------------------------------"
}

# Main script
echo "==== Ollama Model Setup Script ===="
echo "Checking if Ollama is installed..."
check_ollama_installed

echo "Removing all required models (will update if already installed)..."

# List of models to remov
models=(


    "gemma2:2b"
    "gemma2:2b-instruct-q4_0"
    "gemma3:1b"
    "gemma3:4b"
    "granite3.3:2b"
    "granite3.3:8b"
    "internlm2:latest"
    "llama3.2:3b"
    "mistral:7b"
    "mistral:7b-instruct"
    "phi4-mini"
    "llava"

)

# Remove each model
for model in "${models[@]}"; do
    rm_model "$model"
done

echo "==== Model Removals complete! ===="
