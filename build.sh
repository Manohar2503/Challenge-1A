#!/bin/bash

# Build script for PDF Outline Extractor
set -e

echo "Building PDF Outline Extractor Docker image..."

# Generate a random ID for the image
RANDOM_ID=$(openssl rand -hex 8)
IMAGE_NAME="pdf-outline-extractor:${RANDOM_ID}"

# Build the Docker image
docker build -t "${IMAGE_NAME}" .

echo "✅ Build complete!"
echo "🐳 Image name: ${IMAGE_NAME}"
echo ""
echo "📋 Usage:"
echo "docker run --rm -v \$(pwd)/input:/app/input -v \$(pwd)/output:/app/output --network none ${IMAGE_NAME}"
echo ""
echo "📁 Make sure to:"
echo "1. Create an 'input' directory with your PDF files"
echo "2. Create an 'output' directory for JSON results"
echo ""
echo "🧪 Test command:"
echo "mkdir -p input output"
echo "# Place your PDF files in the input directory"
echo "docker run --rm -v \$(pwd)/input:/app/input -v \$(pwd)/output:/app/output --network none ${IMAGE_NAME}"
