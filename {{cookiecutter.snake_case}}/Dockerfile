FROM nixos/nix

WORKDIR /x

# Add init system
RUN nix-env -iA nixpkgs.tini

# Use init system
ENTRYPOINT ["/usr/bin/env", "tini", "--" ]

# Create some stub files to get Cargo to detect a binary project
RUN mkdir src
{%- if cookiecutter.crate_type == "bin" %}
RUN echo "fn main() {}" > src/main.rs
{%- elif cookiecutter.crate_type == "lib" %}
RUN echo "pub struct Placeholder;" > src/lib.rs
{%- endif %}

# Copy required files for Nix operations
COPY default.nix .
COPY Cargo.toml .
{%- if cookiecutter.crate_type == "bin" %}
COPY Cargo.lock .
{%- endif %}

# Build the cache of system dependencies
RUN nix-shell --run exit

# Build the cache of project dependencies
RUN nix-shell --run "cargo build --release"

# Remove the project's stub artifacts
RUN nix-shell --run "cargo clean --release -p {{cookiecutter.snake_case}}"

# Remove the stub code
RUN rm -r src

# Copy in the real code
COPY src src

# Build/cache the actual project executable
RUN nix-shell --run "cargo build --release"

{% if cookiecutter.crate_type == "bin" -%}
# Run the project as the default command
CMD ["nix-shell", "--run", "cargo run --release"]
{%- else -%}
# Run the tests as the default command
CMD ["nix-shell", "--run", "cargo test --release"]
{%- endif %}
