# A minimal Debian-based Python image (small + common + maintained)
FROM python:3.11-slim

# Install curl, then clean up to keep the image small
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user with a real /etc/passwd entry (avoids "I have no name!")
# Use a stable UID/GID so Kubernetes securityContext can reference it if desired.
RUN groupadd -g 1000 appuser \
    && useradd  -u 1000 -g 1000 -m -s /bin/bash appuser

# Make a writable temp dir for restricted setups that enable readOnlyRootFilesystem
# Many tools expect /tmp to be writable.
RUN mkdir -p /tmp && chmod 1777 /tmp

# Switch to non-root by default (critical for PSS restricted)
USER 1000:1000

# Optional: set a sane working directory
WORKDIR /home/appuser

# Default command keeps the pod alive for debugging/POV
CMD ["sh", "-c", "python3 --version && curl --version && sleep 3600"]
