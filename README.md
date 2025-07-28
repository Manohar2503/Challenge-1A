# PDF Outline Extractor - Hackathon Solution

A fast, offline PDF outline extractor that generates structured JSON with document titles and hierarchical headings (H1, H2, H3, H4).

## 🚀 Quick Start

1. **Build the Docker image:**
   ```bash
   chmod +x build.sh test.sh
   ./build.sh
   ```
**Build the Docker image:**
   ```bash
   docker build -t pdf_extractor .
   ```

2. **Prepare your PDFs:**
   ```bash
   mkdir -p input output
   # Copy your PDF files to the input directory
   cp your-document.pdf input/
   ```

3. **Run the extraction:**
   ```bash
   # Linux/Mac Bash Example 
docker run --rm \
  -v "${PWD}/input:/app/input" \
  -v "${PWD}/output:/app/output" \
  document-intelligence

   ```

   # Windows PowerShell Example
docker run --rm `
  -v ${PWD}\input:/app/input `
  -v ${PWD}\output:/app/output `
  document-intelligence


4. **Check results:**
   ```bash
   cat output/your-document.json
   ```

## 📋 Output Format

```json
{
  "title": "Understanding AI",
  "outline": [
    {
      "level": "H1",
      "text": "Introduction",
      "page": 1
    },
    {
      "level": "H2", 
      "text": "What is AI?",
      "page": 2
    },
    {
      "level": "H3",
      "text": "History of AI", 
      "page": 3
    }
  ]
}
```

## 🎯 Features

- **Fast Processing**: Handles 50-page PDFs in under 10 seconds
- **Offline Operation**: No internet connection required
- **Multilingual Support**: Works with Japanese, Chinese, Arabic, and other languages
- **Smart Detection**: Uses multiple strategies:
  - Font size analysis
  - Bold/italic formatting
  - Text patterns (numbered sections, appendices)
  - Position-based hints
- **Lightweight**: Only ~30MB total size
- **Robust**: Handles malformed PDFs gracefully

## 🧠 Detection Strategies

### 1. Font Analysis
- Analyzes font size distribution to identify body text
- Classifies headings based on relative font sizes
- H1: Body font + 5pt or more
- H2: Body font + 3pt or more  
- H3: Body font + 1pt or more (if bold)

### 2. Pattern Recognition
- **Numbered sections**: "1. Introduction", "1.1 Overview"
- **Roman numerals**: "I. Executive Summary"
- **Appendices**: "Appendix A: Data"
- **All caps**: "SUMMARY" (if reasonable length)
- **Colons**: "Background:" (section headers)

### 3. Formatting Cues
- Bold text with larger fonts
- Left-aligned text
- Isolated lines (not part of paragraphs)

### 4. Multilingual Support
- Unicode normalization (NFKC)
- Language-agnostic pattern matching
- Proper handling of CJK characters

## 🔧 Technical Details

- **Base Image**: python:3.11-slim
- **Main Library**: PyMuPDF (fitz) - 30MB
- **Processing**: CPU-only, optimized for speed
- **Memory**: Low memory footprint
- **Platform**: linux/amd64

## 🧪 Testing

Use the included test script:

```bash
./test.sh
```

This will:
1. Build the Docker image
2. Process all PDFs in the input directory
3. Show sample output
4. Verify the results

## 📁 Project Structure

```
pdf-outline-extractor/
|──input     #pdfs
|──output
├── src/
│   └── pdf_extractor.py    # Main extraction logic
├── Dockerfile              # Container definition
├── requirements.txt        # Python dependencies
├── build.sh               # Build script
├── test.sh                # Test script
└── README.md              # This file
```

## 🏆 Hackathon Compliance

✅ **Docker containerized**  
✅ **Reads from `/app/input`**  
✅ **Writes to `/app/output`**  
✅ **No network access required**  
✅ **Under 10 seconds for 50-page PDFs**  
✅ **Model size ≤ 200MB** (actually ~30MB)  
✅ **linux/amd64 platform**  
✅ **Bonus: Multilingual support**

## 🚨 Troubleshooting

**No output files generated?**
- Check that PDF files are in the `input` directory
- Verify PDFs are not password-protected
- Check Docker logs for error messages

**Poor heading detection?**
- The extractor works best with well-formatted PDFs
- Documents with consistent styling produce better results
- Very creative layouts may require manual tuning

**Performance issues?**
- Large PDFs (>100 pages) may take longer
- Complex layouts with many fonts slow processing
- Consider splitting very large documents

## 📈 Performance Benchmarks

- **Small PDFs** (1-10 pages): < 1 second
- **Medium PDFs** (10-50 pages): 2-8 seconds  
- **Large PDFs** (50-100 pages): 5-15 seconds
- **Memory usage**: ~50-100MB per PDF

Perfect for hackathon time constraints! 🎯
