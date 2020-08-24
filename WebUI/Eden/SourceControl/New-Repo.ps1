[CmdletBinding()]
param(
    $Settings,
    [String] $LoggingPrefix,
    [Parameter(Mandatory=$true)]
    [String] $GitHubOrg,
    [Parameter(Mandatory=$true)]
    [String] $GitHubRepo,
    [Parameter(Mandatory=$true)]
    [String] $GitHubPersonalAccessToken
)

    Write-EdenInfo "Adding the service to local git and pushing to a new remote." $LoggingPrefix
    Write-EdenInfo "Initializing the git repo." $LoggingPrefix
    git init
    Write-EdenInfo "Staging all files." $LoggingPrefix
    git add -A
    Write-EdenInfo "Submitting the first commit." $LoggingPrefix
    git commit -m "First commit"
    Write-EdenInfo "Creating the new repo in GitHub." $LoggingPrefix
    $payload = "{`"name`":`"$GitHubRepo`"}"
    $payload
    $headers = @{
        'Authorization' = "token $GitHubPersonalAccessToken"
        'Accept' = 'application/vnd.github.v3+json'
    }
    $response = Invoke-RestMethod `
        -Method POST `
        -Headers $headers `
        -Uri https://api.github.com/user/repos `
        -Body $payload

    $response
    
    Write-EdenInfo "Adding an origin remote pointing at the new GitHub repo." $LoggingPrefix
    git remote add origin https://github.com/$GitHubOrg/$GitHubRepo.git 
    Write-EdenInfo "Pushing the local repo to the remote origin repo." $LoggingPrefix
    git push -u origin master
    Write-EdenInfo "Finished adding the service to local git and pushing to a new remote." $LoggingPrefix
