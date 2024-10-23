# Local (offline) Ollama LLM Docker PowerShell code

> [!NOTE]  
> The basis of this knowledge is the [Ollama](https://ollama.com/) Open-Source instance

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This "project" is my attempt on having a "double-click" solution for hosting a local [RAG](https://blogs.nvidia.com/blog/what-is-retrieval-augmented-generation/) LLM on a computer of any type, with a quick PowerShell script.

The local LLM itself has my own personal use case of summarizing meeting notes  with sensitive information that I make for certain projects, over the weeks, as well as summarizing/talking to my Obsidian notes.

Refer to the Acknowledgement section for the credits on sources where this script was based on :smile:

<!-- GETTING STARTED -->
## Getting Started

### Installation
There are no prerequisites, other than having a good enough HW (no need for next-gen GPU, I promise), if you want to know, I made and ran the LLM using the following specs:

* CPU: 13th Gen Intel(R) Core(TM) i5-13600K
* GPU: RTX 3070 (I didn't run the LLM with the GPU for my light test)
* RAM: 32GB
* OS: Windows 11 Home

#### 1. Setting up Ollama
Firstly you need to get [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/), if you haven't, and then just put

```powershell
# On Windows
winget install Ollama -y
```

```sh
# On Linux
curl -fsSL https://ollama.com/install.sh | sh
```

Once it's finished setting up, you can pull any of the following 3 lightweight libraries, that should be enough for general purposes

> [!IMPORTANT]
> In the [hugging face](https://huggingface.co/models?pipeline_tag=summarization&sort=trending) library, there are plenty other LLM libraries that are specific in their use cases. The problem is, they're **not offline**.

```powershell
ollama pull llama3.1:8b   # For stronger PCs like a home PC
ollama pull llama3.2      # For laptops
ollama pull llama3.2:1b   # For weaker laptops
ollama pull gemma2:2b     # For laptops, but a bit stronger (not-tested)
ollama pull llava         # For analyzing images

#### 2. Setting up Docker

```powershell
winget install Docker.DockerDesktop -y
```

For Linux, follow the setup [here](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

#### 3. Use the scripts
That's it, you can now copy the scripts anywhere in your computer, and use the PowerShell Script that you'd need for your machine

<!-- USAGE EXAMPLES -->
## Usage
### Summary Sam / Note Summary (TBD)
Use the prompts on this text, in order to summarize your notes concisely (based on llama3.x LLM)

### Curator
Use the prompts on this text, in order to analyze pictures (based on llava LLM)

### Code Talker
Use the prompts on this text, in order to generate code to your liking. (based on codellama)

## References
[^1] https://www.youtube.com/watch?v=Wjrdr0NU4Sk

[^2] https://docs.openwebui.com/

## Acknowledgements
* [NetworkChuck](https://www.youtube.com/@NetworkChuck)
* [Open WebUI](https://github.com/open-webui/open-webui)

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.
