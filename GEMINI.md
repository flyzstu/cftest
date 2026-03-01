# GEMINI.md - Project Context: cfdata

## Project Overview
`cfdata` is a Go-based web application designed for scanning and testing Cloudflare IP addresses. It helps users identify optimal Cloudflare data centers by measuring latency and performance from their network environment. The application provides a modern, responsive web interface for easy interaction and utilizes WebSockets for real-time status updates and result reporting.

The project is designed to be highly portable, with pre-compiled binaries provided for a wide range of operating systems (Windows, Linux, macOS, Android, etc.) and architectures (amd64, arm64, mips, etc.).

## Key Features
- **Cloudflare IP Scanning**: Automatically scans ranges of Cloudflare IPv4 and IPv6 addresses.
- **Real-time Latency Testing**: Measures TCP latency to identify the fastest data centers.
- **Detailed Speed Tests**: Performs download speed tests against specific IP addresses.
- **Data Center Mapping**: Maps IP addresses to physical data centers and geographic regions using a local `locations.json` database.
- **Web UI**: A clean, single-page interface for managing tasks and viewing results in real-time.
- **Self-Contained**: The web interface is embedded directly into the Go binary using `go:embed`.

## Technical Stack
- **Backend**: Go (Golang)
- **Frontend**: Vanilla HTML5, CSS3, and JavaScript
- **Real-time Communication**: WebSockets via `github.com/gorilla/websocket`
- **Data Management**: JSON-based location mapping and plain-text IP lists (`ips-v4.txt`, `ips-v6.txt`)

## Project Structure
- `cfdata.go`: The core backend logic, including the HTTP server, WebSocket handlers, and scanning/testing routines.
- `index.html`: The complete frontend UI, embedded into the backend at compile time.
- `go.mod` & `go.sum`: Go module definition and dependency tracking.
- `cfdata-web/`: Contains platform-specific pre-built binaries and essential data files:
    - `locations.json`: Physical location mapping for Cloudflare data centers.
    - `ips-v4.txt`: List of Cloudflare IPv4 ranges/addresses to scan.
    - `ips-v6.txt`: List of Cloudflare IPv6 ranges/addresses to scan.

## Building and Running

### Development
To run the project directly from source:
```bash
go run cfdata.go
```
By default, the service starts at `http://localhost:13335`.

### Compilation
To build a standalone binary for your current platform:
```bash
go build -o cfdata cfdata.go
```

### Command Line Options
- `-port <int>`: Set the service listening port (default: `13335`).
- `-url <string>`: Set the speed test download URL (default: `speed.cloudflare.com/__down?bytes=100000000`).

## Development Conventions
- **Minimalism**: Maintain the project's lightweight nature by favoring the Go standard library.
- **WebSockets**: All asynchronous tasks (scanning, testing) must report progress and results via the established WebSocket protocol.
- **Frontend**: Keep the frontend logic within `index.html` to maintain the single-file simplicity unless complexity necessitates refactoring.
- **Portability**: Ensure that any new features remain compatible with the wide range of supported target platforms.
