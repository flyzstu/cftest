# Build stage
FROM golang:1.23-alpine AS builder

WORKDIR /app

# Copy dependency files
COPY go.mod go.sum ./
RUN go mod download

# Copy source code and data
COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build -o cfdata cfdata.go

# Final stage
FROM alpine:latest

WORKDIR /app

# Install certificates for HTTPS requests
RUN apk --no-cache add ca-certificates

# Copy binary from builder
COPY --from=builder /app/cfdata .
# Copy data files directly to WORKDIR
COPY --from=builder /app/cfdata-web/locations.json .
COPY --from=builder /app/cfdata-web/ips-v4.txt .
COPY --from=builder /app/cfdata-web/ips-v6.txt .

# Expose the default port
EXPOSE 13335

# Run the application
ENTRYPOINT ["./cfdata"]
CMD ["-port", "13335"]
