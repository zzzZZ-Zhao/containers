FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    libc6-dev \
    libgcc1 \
    libgssapi-krb5-2 \
    libicu-dev \
    libssl-dev \
    libstdc++6 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /msamanda

# Copy the MS Amanda binaries
COPY ./bin /msamanda

# Ensure the MS Amanda executable is runnable
RUN chmod +x /msamanda/MSAmanda
