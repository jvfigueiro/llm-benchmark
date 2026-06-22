# Local LLM Benchmark

A pragmatic, straight-to-the-point Shell script to benchmark Large Language Models (LLMs) running locally via Ollama. 

Because trusting official benchmarks run on data center GPU clusters is naive at best. What really matters is the actual inference throughput and stability on your own hardware.

## What does the script do?

* Executes pre-defined prompts on specific models (e.g., `phi4-mini:3.8b`).
* Interacts directly and silently with the local Ollama API.
* Calculates total response time and actual inference speed (`tokens/s`).
* Validates response integrity via `jq` to prevent false positives from timeouts or out-of-memory errors.
* Outputs a quick response sample for coherence validation.

## Prerequisites

Your environment needs a few basic dependencies. Without them, the script will fail to extract the data.

* **Ollama**: The engine running locally (default port `11434`).
* **curl**: To handle HTTP requests to the API.
* **jq**: Essential for parsing the JSON response and extracting telemetry data.
* **bc**: Required for floating-point calculations in bash (calculating tokens per second).

## Installation and Usage
1. Clone the repository or download the `BenchmarkLLM.sh` file directly.
2. Grant execution permissions to script:

   ```bash
   chmod +x BenchmarkLLM.sh
   
4. Run it:
  `./BenchmarkLLM.sh`

## Customization
The script was designed to be easily adapted to your testing pipeline. Edit the BenchmarkLLM.sh file to:

Add Models: Change the initial loop for model in phi4-mini:3.8b; do to include the models you want to compare (e.g., for model in phi4-mini:3.8b llama3:8b mistral; do).

Change the Prompt: Modify the JSON string inside the curl call to test different reasoning levels, math logic, or code generation. The current default tests technical knowledge regarding LXC containers.

## License
This project is licensed under the MIT License - feel free to use, modify, and distribute it.
