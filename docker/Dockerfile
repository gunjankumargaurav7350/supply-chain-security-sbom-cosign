# Stage 1: Build Stage
FROM golang:1.22-alpine AS builder

WORKDIR /src
COPY <<EOF main.go
package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "OK - Secure Supply Chain Active")
	})
	http.ListenAndServe(":8080", nil)
}
EOF

RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /app/server main.go

# Stage 2: Distroless Minimal Non-Root Runtime (Zero CVE Surface)
FROM gcr.io/distroless/static:nonroot

USER nonroot:nonroot
COPY --from=builder /app/server /server

EXPOSE 8080
ENTRYPOINT ["/server"]
