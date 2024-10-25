<#
.SYNOPSIS
	A PowerShell script that's used to prepare a Docker image on Ollama **without** GPU support
.DESCRIPTION
	Target of this script, is to have it as a one-time setup for any computers, even for non-computer savvy users. They
	would just need to have this script on their desktop, double-click it, and Docker (if it has been setup) as well
	as Ollama will set things up.
#>

$DockerArgs = @(
  "-d",
  "-p", "3000:8080",
  "--add-host=host.docker.internal:host-gateway",   # If I comment this one out, the docker run will still work
  "-v", "open-webui:/app/backend/data",
  "--name", "open-webui",
  "--restart", "always",
  "ghcr.io/open-webui/open-webui:main"
) 

try {
  docker run $DockerArgs 2>&1
  if ($LASTEXITCODE -ne 0) {
      throw "Docker run failed with exit code $LASTEXITCODE"
  }
}
catch {
	Write-Error $_.Exception.Message
	# I added this just because end-users would be able to see what the problem was
	Read-Host "Press Enter to exit"
	break
}

Write-Output "Open-WebUI Instance running in the background. Open http://localhost:3000 in browser to access local LLM WebUI"
# I added this just because end-users would be able to see that something happens
Read-Host "Press Enter to continue"
