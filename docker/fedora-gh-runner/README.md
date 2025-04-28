# Fedora github runner
Create a github actions runner on fedora in docker.

Kinda limited to what works but it's something

## Usage: 
- `sudo docker build -t fedora-runner .`
- `docker run -e GITHUB_URL=https://github.com/your-org/your-repo -e GITHUB_TOKEN=<YOUR GITHUB RUNNER TOKEN> fedora-runner`
