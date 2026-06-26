# Local LLM Benchmark

A pragmatic, straight-to-the-point set of scripts (Bash & PowerShell) to benchmark Large Language Models (LLMs) running locally via Ollama. 

Because trusting official benchmarks run on data center GPU clusters is naive at best. What really matters is the actual inference throughput and stability on your own hardware.

## What do the scripts do?

* Execute pre-defined prompts on specific models (e.g., `gemma4:e4b`).
* Interact directly and silently with the local Ollama API.
* Calculate total response time and actual inference speed (`tokens/s`).
* Validate response integrity to prevent false positives from timeouts or out-of-memory errors.
* Output a quick response sample for coherence validation.

## Prerequisites

Your environment needs a few basic dependencies depending on your operating system.

### For Windows
* **Ollama**: The engine running locally (default port `11434`).
* **None**: The `BenchmarkLLM.ps1` script leverages native .NET classes and PowerShell objects. It requires zero external binaries, keeping your system lean without cluttering your environment with WSL or third-party tools.

### For Linux/macOS
* **Ollama**: The engine running locally (default port `11434`).
* **curl**: To handle HTTP requests to the API.
* **jq**: Essential for parsing the JSON response and extracting telemetry data.
* **bc**: Required for floating-point calculations in bash (calculating tokens per second).

## Installation and Usage

Clone the repository or download the scripts directly to your machine.

### Windows
By default, Windows restricts script execution for security reasons. To run the benchmark, open PowerShell and temporarily bypass the restriction for the current session:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\BenchmarkLLM.ps1
```

### Linux / macOS
Grant execution permissions to the script and run it:
```bash
chmod +x BenchmarkLLM.sh
./BenchmarkLLM.sh
```

### Customization
The scripts were designed to be easily adapted to your testing pipeline. Edit either BenchmarkLLM.sh or BenchmarkLLM.ps1 to:

* Add Models: Change the initial array/loop (e.g., phi4-mini:3.8b, llama3:8b, mistral) to include the models you want to compare.

* Change the Prompt: Modify the payload to test different reasoning levels, math logic, or code generation. The current default tests technical knowledge regarding LXC containers.

### License
This project is licensed under the MIT License - feel free to use, modify, and distribute it.
