FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY src/ ./src/

# Create input and output directories
RUN mkdir -p /app/input /app/output

# Make the script executable
RUN chmod +x src/pdf_extractor.py

# Set the entrypoint
ENTRYPOINT ["python", "src/pdf_extractor.py"]
