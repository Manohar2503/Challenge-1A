#!/bin/bash

# Test script for PDF Outline Extractor
set -e

echo "🧪 Testing PDF Outline Extractor..."

# Create test directories
mkdir -p input output

# Check if there are PDF files in input
if [ ! "$(ls -A input/*.pdf 2>/dev/null)" ]; then
    echo "❌ No PDF files found in input directory"
    echo "Please add some PDF files to the 'input' directory and run this script again."
    exit 1
fi

# Build the image
echo "🔨 Building Docker image..."
./build.sh

# Extract image name from build output
IMAGE_NAME=$(docker images --format "table {{.Repository}}:{{.Tag}}" | grep pdf-outline-extractor | head -1)

if [ -z "$IMAGE_NAME" ]; then
    echo "❌ Failed to find built image"
    exit 1
fi

echo "🚀 Running extraction with image: $IMAGE_NAME"

# Run the extraction
docker run --rm \
    -v "$(pwd)/input:/app/input" \
    -v "$(pwd)/output:/app/output" \
    --network none \
    "$IMAGE_NAME"

echo ""
echo "✅ Extraction complete!"
echo "📄 Check the 'output' directory for JSON files"

# Show results
if [ "$(ls -A output/*.json 2>/dev/null)" ]; then
    echo ""
    echo "📊 Generated files:"
    ls -la output/*.json
    
    echo ""
    echo "🔍 Sample output:"
    head -20 output/*.json | head -20
else
    echo "❌ No output files generated"
fi
