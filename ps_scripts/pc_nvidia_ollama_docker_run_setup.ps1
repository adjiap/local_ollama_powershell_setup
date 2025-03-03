<#
.SYNOPSIS
	A PowerShell script that's used to prepare an Open-WebUI Docker image **with** GPU support
.DESCRIPTION
	Target of this script, is to have it as a one-time setup for any computers, even for non-computer savvy users. They
	would just need to have this script on their desktop, double-click it. As long as Docker and Ollama has been set up
  in the background, Open-WebUI will be good to go
#>

$RepoName = "ghcr.io/open-webui/open-webui"
$RepoTag = "cuda"
$ContainerName = "open-webui-cuda"
$LocalPort = 3000
$DockerArgs = @(
  "-d",
  "-p", "${LocalPort}:8080",
  "--add-host=host.docker.internal:host-gateway",  # If I comment this one out, the docker run will still work
	"--gpus=all",
  "-v", "open-webui:/app/backend/data",
  "--name", $ContainerName,
  "--restart", "always",
  "${RepoName}:$RepoTag"
) 

try {
  docker run $DockerArgs 2>$null
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
