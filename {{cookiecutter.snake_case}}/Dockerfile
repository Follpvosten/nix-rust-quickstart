FROM nixos/nix

WORKDIR /x

# Add init system
RUN nix-env -iA nixpkgs.tini

# Use init system
ENTRYPOINT ["/usr/bin/env", "tini", "--" ]

# Create some stub files to get Cargo to detect a binary project
RUN mkdir src
RUN echo "fn main() {}" > src/main.rs

# Copy required files for Nix operations
COPY default.nix .
COPY Cargo.toml .
COPY Cargo.lock .

# Build the cache of system dependencies
RUN nix-shell --run exit

# Build the cache of project dependencies
RUN nix-shell --run "cargo build --release"

# Remove the project's stub binary
RUN nix-shell --run "cargo clean --release -p {{cookiecutter.snake_case}}"

# Remove the stub code
RUN rm -r src

# Run the project as the default command
CMD ["nix-shell", "--run", "cargo run --release"]
