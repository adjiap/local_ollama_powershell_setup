# Local (offline) Ollama PowerShell Setup

> [!NOTE]  
> The basis of this knowledge is the [Ollama](https://ollama.com/) Open-Source instance

## Table of Contents
<ol>
  <li>
    <a href="#about-the-project">About The Project</a>
  </li>
  <li>
    <a href="#getting-started">Getting Started</a>
    <ul>
      <li><a href="#installation">Installation</a></li>
      <li><a href="#installation-of-scripts-bundled-with-ollama">Installation of scripts bundled with Ollama</a></li>
    </ul>
  </li>
  <li><a href="#acknowledgements">Acknowledgements</a></li>
  <li><a href="#license">License</a></li>
</ol>

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

#### 1. Setting up Ollama<sup>[1]</sup>
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
```

#### 2. Setting up Docker

```powershell
winget install Docker.DockerDesktop -y
```

For Linux, follow the setup [here](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

#### 3. Use the scripts
That's it, you can now copy the scripts anywhere in your computer, and use the PowerShell Script that you'd need for your machine. You can access the Open WebUI by using any browser and putting in the URL http://localhost:3000
> [!NOTE]
> When you first enter open WebUI, you need to sign up for an account. Just use a "dummy" account, and then put in the password (try not to lose it)
> 
> ![image](https://github.com/user-attachments/assets/f7f73b74-144d-4c62-a347-cf76bf0f8451)

### Installation of scripts bundled with Ollama
Under the `ps_scripts_bundled` folder, ther are nearly identical PowerShell scripts, but it also instantiates Ollama together with Open WebUI in the same docker image.
You'd still however need to download the Ollama models after setting up the Open WebUI, and you can do so like this:'
- Go to Admin Settings
![image](https://github.com/user-attachments/assets/890a61f3-e751-4d6d-80dd-1eaf0e60cf84)

- Go to Settings -> Models -> Pull Models and enter the name of the suggested Ollama models as above (e.g. llama3.2, llama3.1:8b
![image](https://github.com/user-attachments/assets/10369250-ba3c-471c-a4dc-650fb8e48753)

<!-- USAGE EXAMPLES -->
## Usage
For a more precise prompt, use the following system prompts for the specific [use-cases](system_prompts/README.md). They are located in `/system_prompts`

* [Summary Sam](system_prompts/summary_sam.md)
* [The Librarian](system_prompts/the_librarian.md)
* [Curator](system_prompts/curator.md)
* [Code Talker](system_prompts/code_talker.md)

## References
<sup>[1]</sup> https://www.youtube.com/watch?v=Wjrdr0NU4Sk

<sup>[2]</sup> https://docs.openwebui.com/

## Acknowledgements
* [NetworkChuck](https://www.youtube.com/@NetworkChuck)
* [Open WebUI](https://github.com/open-webui/open-webui)

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.
