# Secure Node.js Docker Setup 🛡️📦

A production-ready, hardened Docker configuration for Node.js applications. This project demonstrates **Security-by-Design** principles by minimizing the attack surface and enforcing least privilege.

## 🚀 Key Security Controls

### 1. Minimal Attack Surface (Alpine Linux)

Instead of using the full Debian-based image (`node:18`), this setup uses **Alpine Linux** (`node:18-alpine`).

-   **Why?** It drastically reduces the image size (from ~1GB to ~170MB) and, more importantly, removes hundreds of unnecessary system binaries and libraries that could be potential vectors for CVEs.

### 2. Least Privilege (Non-Root User)

By default, Docker containers run as `root`. This configuration switches to a standard user (`node`) provided by the image.

-   **Why?** If an attacker compromises the application (e.g., via RCE), they will only have limited permissions inside the container, preventing them from modifying system files or installing malware.

```dockerfile
# From Dockerfile
USER node
```

### 3. Vulnerability Scanning (Trivy)

Integrated Trivy scanning to detect vulnerabilities in OS packages and application dependencies during the build process.

Proof: See trivy-results.txt for a sample scan output identifying base image vulnerabilities.

🛠️ How to Use

1. Build the secure image
   Bash

docker build -t secure-node-app . 2. Run the container (verifying non-root user)
Bash

docker run --rm secure-node-app whoami

# Output should be: node (NOT root)

3. Scan for vulnerabilities
   Bash

trivy image secure-node-app
📂 Files Included
Dockerfile: The hardened multi-stage configuration.

trivy-results.txt: Sample vulnerability scan log.

.dockerignore: Ensures sensitive files (like .env or .git) are not copied into the image.

package.json & index.js: A sample app to demonstrate the build process.

_Created by [Muhammad Sayyid](https://www.linkedin.com/in/muhammad-sayyid/) - Aspiring AppSec Engineer._
