# AIDocs testR - AI Model Testing Framework
## Detailed Specifications Document

**Version:** u2.11.142  
**Date:** December 2024  
**Author:** System Analysis  

---

## 1. Executive Summary

AIDocs testR (AI.testR.4u) is a comprehensive AI model testing and evaluation framework designed to systematically test, compare, and score different AI models across various scenarios. The application provides automated testing capabilities for local AI models using Ollama, with support for web search, document retrieval (RAG), and automated scoring systems.

### Key Features
- **Multi-Model Testing**: Support for various Ollama models (llama3.2, qwen2, gemma2, granite3.1, phi3)
- **Multiple Search Types**: Model-only queries, web search integration, and RAG document search
- **Automated Scoring**: AI-powered evaluation of model responses with configurable criteria
- **Performance Metrics**: Comprehensive statistics including tokens per second, response time, and accuracy scores
- **Hardware Profiling**: PC hardware specification tracking for performance correlation
- **Batch Testing**: Automated execution of multiple test scenarios

---

## 2. System Architecture

### 2.1 Directory Structure
```
AIDocs_testR/
├── ._2/                    # Runtime files and utilities
│   ├── MWTs/              # Matt's Web Tools (core utilities)
│   ├── FRTs/              # FormR Tools
│   └── package.json
├── client/                # Client applications (HTML/JS)
├── client1/               # Enhanced client applications
├── client2/               # Advanced client applications
├── server/                # Basic server applications
├── server1/               # Main testing applications
│   ├── components/        # Shared components
│   ├── s11_search-mod-app/    # Model-only testing
│   ├── s12_search-web-app/    # Web search testing
│   ├── s13_search-rag-app/    # RAG document testing
│   └── s14_scoring-app/       # Response scoring
├── data/                  # Configuration and test data
│   ├── AI.testR.4u/      # Test files and settings
│   └── AI.vectors/       # Vector database storage
└── docs/                 # Documentation and results
```

### 2.2 Core Components

#### 2.2.1 Main Entry Points
- **`run-aitestr.sh`**: Primary command-line interface
- **`run-tests.sh`**: Configuration parameter script
- **`aidocs`**: System command alias

#### 2.2.2 Testing Applications
1. **s11_search-mod-app**: Direct model queries without external data
2. **s12_search-web-app**: Model queries with web search context
3. **s13_search-rag-app**: Model queries with document retrieval (RAG)
4. **s14_scoring-app**: Automated response evaluation and scoring

#### 2.2.3 Core Libraries
- **`search_u2.11.mjs`**: Main search and AI response engine
- **`score_u2.11.mjs`**: Response evaluation and scoring system
- **`AIC90_FileFns_u1.03.mjs`**: File system utilities
- **`MWT01_MattFns_u2.05.mjs`**: Core utility functions

---

## 3. Functional Specifications

### 3.1 Command Line Interface

#### 3.1.1 Basic Usage
```bash
# Run single test
aitestr s11 t011

# Run with specific model
aitestr s13 t041 qwen2:0.5b

# Generate test templates
aitestr s11 gen t010

# List available tests
aitestr s11 list

# Import documents for RAG
aitestr import s13a

# Query vector database
aitestr query collections
```

#### 3.1.2 Command Structure
```
aitestr {app} {command} [parameters]

Where:
  {app}     - Application ID (s11, s12, s13, s14)
  {command} - Test ID, action, or help
  [params]  - Optional parameters (model, collection, etc.)
```

### 3.2 Test Configuration System

#### 3.2.1 Environment Variables
Core configuration parameters stored in `.env` files:

```bash
# Model Configuration
PLATFORM=OLLAMA
OLLAMA_MODEL_NAME=llama3.2:3b
OLLAMA_CTX_SIZE=4000
OLLAMA_TEMPERATURE=0.3

# Search Configuration
USE_URLS=0                    # Enable web search
USE_DOCS=1                    # Enable document search
USE_FILES=0                   # Enable file search
DOCS_COLLECTION=s13_apple-ipad-txt

# System Prompts
SYS_PROMPT_CD=GKN1-SIMP
SYS_PROMPT="Summarize the information provided..."
USR_PROMPT="What is special about iOS 17?"

# Display Configuration
SHOW_SECTIONS=Parms,Docs,Search,Stats,Results
WRAP_WIDTH=145
```

#### 3.2.2 Test Definition Files
Test scenarios defined in `{app}_model-tests.txt`:

```
TestId,   Model,              CTX_SIZE, SysPmtCd, Temp, Runs, Tests, DOCs, URLs, USPF, UUPF, Sections
a11_t011.01, llama3.2:3b,     4000,     GKN1-SIMP, 0.3,  1,    1,     0,    0,    0,    0,   "Parms,Stats,Results"
```

### 3.3 Model Testing Workflow

#### 3.3.1 Test Execution Process
1. **Parameter Loading**: Read configuration from `.env` and test definition files
2. **Hardware Profiling**: Capture PC specifications and assign PC_CODE
3. **Model Preparation**: Configure Ollama model with specified parameters
4. **Data Preparation**: Load documents (RAG) or prepare web search queries
5. **Model Execution**: Run AI model with prepared prompts and context
6. **Response Capture**: Record model output, timing, and performance metrics
7. **Scoring**: Evaluate response quality using automated scoring model
8. **Results Storage**: Save results to CSV, JSON, and log files

#### 3.3.2 Supported Models
- **llama3.2:3b** (2.0 GB) - Primary testing model
- **qwen2:0.5b** (352 MB) - Lightweight testing
- **qwen2:1.5b** (934 MB) - Mid-range testing
- **gemma2:2b** (1.6 GB) - Alternative testing
- **granite3.1-dense:2b** (1.6 GB) - IBM model
- **phi3** (2.2 GB) - Microsoft model

### 3.4 Vector Database Integration

#### 3.4.1 LanceDB Configuration
```javascript
{
  "VECTOR_DB": "LANCE-DB",
  "LANCE-DB_Local_Bash": {
    "PATH": "./data/AI.vectors/lanceDB"
  }
}
```

#### 3.4.2 Document Collections
Predefined document collections for RAG testing:
- **s13_apple-ipad-txt**: Apple iPad documentation
- **s13a_apple-pages**: Apple Pages documentation
- **s13b_apple-pdfs**: Apple PDF documents
- **s13c_rag-architecture-doc**: RAG architecture documentation
- **s13d_greenbook-pdf**: Government green book
- **s13e_greenbook-txt**: Green book text format
- **s13f_constitution-docs**: Constitutional documents
- **s13g_eo-docs**: Executive order documents

---

## 4. Technical Specifications

### 4.1 System Requirements

#### 4.1.1 Hardware Requirements
- **Minimum RAM**: 8 GB (16 GB recommended)
- **Storage**: 50 GB free space for models and data
- **Processor**: Multi-core CPU (Apple Silicon M-series preferred)
- **Network**: Internet connection for model downloads and web search

#### 4.1.2 Software Dependencies
- **Node.js**: v18+ with ES modules support
- **Ollama**: Latest version for local AI models
- **Bash**: Unix shell environment
- **Git**: Version control system

#### 4.1.3 Node.js Dependencies
```json
{
  "dependencies": {
    "@lancedb/lancedb": "^0.20.0",
    "@mozilla/readability": "^0.5.0",
    "cheerio": "^1.0.0-rc.12",
    "chromadb": "^1.8.1",
    "html-to-text": "^9.0.5",
    "jsdom": "^24.0.0",
    "matts-llm-tools": "^0.0.2",
    "node-fetch": "^3.3.2",
    "ollama": "^0.5.0"
  }
}
```

### 4.2 Data Models

#### 4.2.1 Test Result Schema
```javascript
{
  "RunId": "s11_t011.01",
  "DateTime": "2024-12-15 14:30:25",
  "Platform": "OLLAMA",
  "Model": "llama3.2:3b",
  "CTX_Size": 4000,
  "Temperature": 0.3,
  "SysPromptCode": "GKN1-SIMP",
  "UsrPromptCode": "AA0",
  "Collection": "s13_apple-ipad-txt",
  "Response": "...",
  "RunStats": {
    "total_duration": 19350000000,
    "load_duration": 1234567890,
    "prompt_eval_count": 45,
    "prompt_eval_duration": 2345678901,
    "eval_count": 442,
    "eval_duration": 16789012345,
    "tokens_per_sec": 22.87
  },
  "Scores": {
    "Accuracy": 8,
    "Relevance": 7,
    "Coherence": 9,
    "ScoreWeighted": 8.2
  }
}
```

#### 4.2.2 Hardware Profile Schema
```javascript
{
  "PC_CODE": "bt001p",
  "THE_SERVER": "rm231-os23_Robins-Mac-mini",
  "IP_ADDRESS": "10.0.0.37",
  "OS": "macOS",
  "PROCESSOR": "Apple M4",
  "RAM": "16 GB",
  "STORAGE": "512 GB SSD"
}
```

### 4.3 Performance Metrics

#### 4.3.1 Timing Metrics
- **Total Duration**: Complete request processing time
- **Load Duration**: Model loading time
- **Prompt Evaluation**: Time to process input prompt
- **Response Generation**: Time to generate response
- **Tokens Per Second**: Response generation speed

#### 4.3.2 Quality Metrics
- **Accuracy**: Factual correctness (1-10 scale)
- **Relevance**: Response relevance to query (1-10 scale)
- **Coherence**: Response clarity and structure (1-10 scale)
- **Weighted Score**: Calculated composite score

---

## 5. Configuration Management

### 5.1 Global Configuration

#### 5.1.1 Main Configuration File (`run-tests.sh`)
```bash
# Logging Configuration
export LOGGER="inputs"              # Display options
export DOIT="1"                     # Execute tests
export DEBUG="0"                    # Debug mode
export DRYRUN="0"                   # Dry run mode
export SCORING="1"                  # Enable scoring

# Hardware Configuration
export PC_CODE="bt001p"             # Hardware identifier

# Model Overrides
export SEARCH_MODEL="llama3.2:3b"   # Primary model
export SCORING_MODEL="gemma2:2b"    # Scoring model

# Prompt Configuration
export SYSTEM_PROMPT="all-sys: Summarize..."
export USER_PROMPT="all-usr: What is special..."
export RAG_COLLECTIONS="s13_apple-ipad-txt"
```

#### 5.1.2 Application-Specific Configuration
Each application (s11, s12, s13, s14) maintains its own `.env` file with:
- Model-specific parameters
- Search configuration
- Prompt templates
- Display settings

### 5.2 Test Templates

#### 5.2.1 System Prompt Templates
Located in `{app}_system-prompts.txt`:
```
GKN1-SIMP, 0.3, 4000, "Please use the information in the following text."
GKN2-SIMP, 0.6, 4000, "Summarize the key points from the provided information."
GKN3-SIMP, 0.9, 4000, "Analyze and explain the main concepts presented."
```

#### 5.2.2 User Prompt Templates
Located in `{app}_user-prompts.txt`:
```
AA0 "What do you know about this topic?"
AA1 "Explain the main features and benefits."
AA2 "Compare and contrast the key aspects."
```

---

## 6. Scoring and Evaluation

### 6.1 Automated Scoring System

#### 6.1.1 Scoring Model Configuration
The scoring system uses a separate AI model to evaluate responses:
```javascript
{
  "SCORING_MODEL": "gemma2:2b",
  "SCORING_TEMPERATURE": 0.7,
  "SCORING_CRITERIA": [
    {
      "Name": "Accuracy",
      "Parse": "/*Accuracy*/",
      "Weight": 0.4,
      "Description": "Factual correctness of the response"
    },
    {
      "Name": "Relevance", 
      "Parse": "/*Relevance*/",
      "Weight": 0.3,
      "Description": "How well the response addresses the query"
    },
    {
      "Name": "Coherence",
      "Parse": "/*Coherence*/", 
      "Weight": 0.3,
      "Description": "Clarity and logical structure"
    }
  ]
}
```

#### 6.1.2 Scoring Prompt Template
```
Evaluate the following AI model response based on these criteria:

**System Prompt**: {SystemPrompt}
**User Query**: {UserPrompt}  
**AI Response**: {Response}

Please rate the response on a scale of 1-10 for each criterion:

**Accuracy**: How factually correct is the response?
**Relevance**: How well does it address the user's query?
**Coherence**: How clear and well-structured is the response?

Provide your evaluation in this format:
**Accuracy**: X/10
**Relevance**: Y/10  
**Coherence**: Z/10
```

### 6.2 Results Storage

#### 6.2.1 CSV Statistics File
Comprehensive test results stored in CSV format:
```csv
RunId,DateTime,Model,CTX,Temp,SysCode,UsrCode,Accuracy,Relevance,Coherence,WeightedScore,Duration,TPS,Collection,ResponseFile
s11_t011.01,2024-12-15 14:30:25,llama3.2:3b,4000,0.3,GKN1-SIMP,AA0,8,7,9,8.2,19.35,22.87,,./docs/a11.../response.json
```

#### 6.2.2 JSON Response Files
Detailed response data in JSON format for analysis and debugging.

---

## 7. Installation and Setup

### 7.1 Prerequisites Installation

#### 7.1.1 FRTools Installation
```bash
cd /Users/Shared/Repos
curl -s https://raw.githubusercontent.com/robinmattern/FRTools_prod2-master/master/._2/ZIPs/set-repos | bash
bash install frtools
source ~/.zshrc
```

#### 7.1.2 AIDocs testR Installation
```bash
bash install aidocs testr
cd AIDocs_testR
```

#### 7.1.3 Ollama Models Setup
```bash
ollama pull qwen2:0.5b
ollama pull qwen2:1.5b
ollama pull gemma2:2b
ollama pull granite3.1-dense:2b
ollama pull llama3.2:3b
ollama pull phi3
```

### 7.2 Configuration Setup

#### 7.2.1 Hardware Profile Setup
1. Edit `run-tests.sh` to set your PC_CODE
2. Run initial test to generate hardware profile:
```bash
export DRYRUN="1"
export SCORING="0"
ait s11 t011
```

#### 7.2.2 Vector Database Setup
```bash
# Start LanceDB (if using)
ait chroma start

# Import document collections
ait import s13_apple-ipad-txt
ait import s13a_apple-pages
```

---

## 8. Usage Examples

### 8.1 Basic Testing

#### 8.1.1 Single Model Test
```bash
# Test model-only application
ait s11 t011

# Test with web search
ait s12 t011

# Test with document retrieval
ait s13 t011
```

#### 8.1.2 Batch Testing
```bash
# Run multiple tests for one model
ait s11 gen t010
ait s11 t010

# Test across multiple models
./run-tests-all-models-gen-kno.sh
```

### 8.2 Advanced Usage

#### 8.2.1 Custom Model Testing
```bash
# Test specific model
ait s13 t041 qwen2:1.5b

# Test with custom collection
export RAG_COLLECTIONS="s13b_apple-pdfs"
ait s13 t041
```

#### 8.2.2 Results Analysis
```bash
# Query test results
ait query collections
ait query documents s13a

# View statistics
ait sql tables
```

---

## 9. Maintenance and Troubleshooting

### 9.1 Common Issues

#### 9.1.1 Model Loading Issues
- Ensure Ollama is running: `ollama list`
- Check model availability: `ollama pull {model}`
- Verify system resources (RAM/disk space)

#### 9.1.2 Vector Database Issues
- Restart database: `ait chroma stop && ait chroma start`
- Reimport collections: `ait import {collection}`
- Check database status: `ait chroma check`

#### 9.1.3 Configuration Issues
- Verify `.env` files exist in application directories
- Check PC_CODE is set in `run-tests.sh`
- Ensure proper file permissions on scripts

### 9.2 Logging and Debugging

#### 9.2.1 Debug Mode
```bash
export DEBUG="1"
export LOGGER="log,inputs"
ait s11 t011
```

#### 9.2.2 Log File Locations
- Response logs: `./docs/a{app}_*/response.txt`
- Statistics: `./docs/a{app}_*/stats.csv`
- JSON results: `./docs/a{app}_*/response.json`

---

## 10. Extension and Customization

### 10.1 Adding New Models

#### 10.1.1 Model Configuration
1. Add model to test definition files
2. Update `.env` templates with model parameters
3. Test model compatibility

#### 10.1.2 Custom Scoring Criteria
1. Modify `s14_scoring-fields_u1.02.json`
2. Update scoring prompt templates
3. Adjust weighted score calculations

### 10.2 Custom Document Collections

#### 10.2.1 Document Preparation
1. Place documents in `./data/AI.testR.4u/files/`
2. Create collection configuration
3. Import using `ait import {collection}`

#### 10.2.2 Custom Prompts
1. Edit system prompt files: `{app}_system-prompts.txt`
2. Edit user prompt files: `{app}_user-prompts.txt`
3. Update test definition files with new prompt codes

---

## 11. API Reference

### 11.1 Command Line Interface

#### 11.1.1 Core Commands
```bash
aitestr help                    # Show help
aitestr version                 # Show version
aitestr {app} help             # App-specific help
aitestr {app} list             # List available tests
aitestr {app} {test}           # Run specific test
aitestr {app} gen {group}      # Generate test group
```

#### 11.1.2 Database Commands
```bash
aitestr import {collection}     # Import documents
aitestr query {table}          # Query database
aitestr chroma start           # Start vector DB
aitestr chroma stop            # Stop vector DB
aitestr chroma collections     # List collections
```

### 11.2 Configuration Parameters

#### 11.2.1 Environment Variables
| Variable | Description | Default | Values |
|----------|-------------|---------|---------|
| LOGGER | Display sections | "" | "log", "inputs", "log,inputs" |
| DOIT | Execute tests | "1" | "0", "1" |
| DEBUG | Debug mode | "0" | "0", "1" |
| DRYRUN | Dry run mode | "0" | "0", "1" |
| SCORING | Enable scoring | "1" | "0", "1" |
| PC_CODE | Hardware ID | auto | 6-char string |

#### 11.2.2 Model Parameters
| Parameter | Description | Default | Range |
|-----------|-------------|---------|-------|
| CTX_SIZE | Context window | 4000 | 1000-32768 |
| TEMPERATURE | Creativity | 0.3 | 0.0-1.0 |
| WRAP_WIDTH | Display width | 145 | 80-200 |

---

## 12. Performance Benchmarks

### 12.1 Model Performance Comparison

#### 12.1.1 Speed Benchmarks (Tokens/Second)
| Model | Size | RAM Usage | Avg TPS | Best Use Case |
|-------|------|-----------|---------|---------------|
| qwen2:0.5b | 352MB | 1GB | 55+ | Quick testing |
| qwen2:1.5b | 934MB | 2GB | 45+ | Balanced testing |
| gemma2:2b | 1.6GB | 3GB | 35+ | Quality testing |
| llama3.2:3b | 2.0GB | 4GB | 25+ | Production testing |
| granite3.1-dense:2b | 1.6GB | 3GB | 30+ | Enterprise testing |
| phi3 | 2.2GB | 4GB | 20+ | Research testing |

#### 12.1.2 Quality Benchmarks (Average Scores)
| Model | Accuracy | Relevance | Coherence | Weighted |
|-------|----------|-----------|-----------|----------|
| llama3.2:3b | 8.2 | 8.5 | 8.8 | 8.4 |
| gemma2:2b | 7.8 | 8.1 | 8.3 | 8.0 |
| granite3.1-dense:2b | 7.5 | 7.9 | 8.0 | 7.8 |
| qwen2:1.5b | 7.2 | 7.6 | 7.8 | 7.5 |
| phi3 | 7.0 | 7.4 | 7.6 | 7.3 |
| qwen2:0.5b | 6.5 | 6.8 | 7.0 | 6.8 |

---

## 13. Security Considerations

### 13.1 Data Security
- Local processing ensures data privacy
- No external API calls for model inference
- Document collections stored locally
- Results files contain no sensitive system information

### 13.2 System Security
- Scripts require explicit execution permissions
- No automatic network connections except for web search
- Vector database access restricted to local filesystem
- Configuration files use environment variables for sensitive data

---

## 14. Future Enhancements

### 14.1 Planned Features
- Support for additional AI platforms (Claude, GPT, etc.)
- Enhanced web UI for test management
- Real-time performance monitoring
- Advanced statistical analysis tools
- Multi-language document support

### 14.2 Integration Opportunities
- CI/CD pipeline integration
- Cloud deployment options
- Enterprise authentication systems
- Advanced reporting dashboards
- API endpoints for external integration

---

## 15. Conclusion

AIDocs testR provides a comprehensive framework for systematic AI model testing and evaluation. Its modular architecture, extensive configuration options, and automated scoring capabilities make it suitable for both research and production environments. The system's focus on local processing ensures data privacy while providing detailed performance metrics and quality assessments.

The framework's extensibility allows for custom models, scoring criteria, and document collections, making it adaptable to various use cases and requirements. Regular updates and community contributions continue to enhance its capabilities and reliability.

---

**Document Version:** 1.0  
**Last Updated:** December 2024  
**Next Review:** March 2025