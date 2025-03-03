<#
.SYNOPSIS
	A PowerShell script that's used to prepare an Open-WebUI Docker container
.DESCRIPTION
	Target of this script, is to have it as a one-time setup for any computer, even for non-computer savvy users. They
	would just need to have this script on their desktop, double-click it. As long as Docker and Ollama has been set up
  in the background, Open-WebUI will be good to go.  The script will automatically install the CUDA version
  if it finds CUDA-Compatible Hardware.
#>

$RepoName = "ghcr.io/open-webui/open-webui"
$LocalPort = 3000
$IsCUDACapable = (Get-WmiObject Win32_VideoController).Name -like "*NVIDIA*"
$RepoTag =
  if ($IsCUDACapable) {
    "cuda"
  } else {
    "main"
  }
$ContainerName = "open-webui-$RepoTag"
$DockerArgs = @(
  "-d",
  "-p", "${LocalPort}:8080",
  "--add-host=host.docker.internal:host-gateway",  # If I comment this one out, the docker run will still work
  "-v", "open-webui:/app/backend/data",
  "--name", $ContainerName,
  "--restart", "always"
)

try {
  if ((docker ps 2>&1) -like "*error during connect*dockerDesktopLinuxEngine*") {
    Write-Output "Docker Desktop is offline. Starting up Docker."
    Start-Process -FilePath "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    Start-Sleep -s 5 # Arbitrary 5 seconds of wait to start Docker
  }
} catch {
  throw "Something went wrong with starting Docker. Please start it manually first."
  break
}

if ($IsCUDACapable){
  Write-Output "NVIDIA GPU detected. Instantiating CUDA version"
  $DockerArgs += "--gpus=all"
}
else {
  Write-Output "No NVIDIA GPU detected. Instantiating CPU version"
}

try {
  docker run $DockerArgs ${RepoName}:$RepoTag 2>$null
  if ($LASTEXITCODE -eq 125) {
    throw "Open WebUI instance with the name '$ContainerName' already exists. Skipping instantiation."
  }
  elseif ($LASTEXITCODE -ne 0) {
    throw "Docker run failed with exit code $LASTEXITCODE"
  }
}
catch {
	Write-Error $_.Exception.Message
	# I added this just because end-users would be able to see what the problem was
	Read-Host "Press Enter to exit"
	break
}

Write-Output "Open-WebUI Instance running in the background. Open http://localhost:${LocalPort} in browser to access local LLM WebUI"
# I added this just because end-users would be able to see that something happens
Read-Host "Press Enter to continue"
