<#
.SYNOPSIS
	A PowerShell script that's used to prepare an Open-WebUI and Ollama Docker image
.DESCRIPTION
	Target of this script, is to have it as a one-time setup for any computers, even for non-computer savvy users. They
	would just need to have this script on their desktop, double-click it, and Docker (if it has been setup) will setup
	Open-WebUI and Ollama LLM. The script will automatically install the CUDA version if it finds CUDA-Compatible Hardware.
#>

#region Initialize Variables
$RepoName = "ghcr.io/open-webui/open-webui"
$RepoTag = "ollama"
$IsCUDACapable = (Get-WmiObject Win32_VideoController).Name -like "*NVIDIA*"
$ContainerName = "open-webui-bundled"
$LocalPort = 3000
$DockerArgs = @(
  "-d",
  "-p", "${LocalPort}:8080",
  "--add-host=host.docker.internal:host-gateway",  # If I comment this one out, the docker run will still work
	"--gpus=all",
  "-v", "open-webui:/app/backend/data",
  "-v", "ollama:/root/.ollama",
  "--name", $ContainerName,
  "--net=host",
  "--restart", "always"
) 
#endregion

#region Test if Docker Engine is on
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
#endregion

#region Update run arguments due to CUDA
if ($IsCUDACapable){
  Write-Output "NVIDIA GPU detected. Instantiating CUDA version"
  $DockerArgs += "--gpus=all", "--net=host"
}
else {
  Write-Output "No NVIDIA GPU detected. Instantiating CPU version"
}
#endregion

#region Run Open-WebUI Container
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
#endregion

#region Inform user
Write-Output "Open-WebUI Instance running in the background. Open http://localhost:${LocalPort} in browser to access local LLM WebUI"
# I added this just because end-users would be able to see that something happens
Read-Host "Press Enter to continue"
#endregion
