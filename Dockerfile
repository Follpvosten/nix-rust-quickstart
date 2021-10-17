FROM nixos/nix

WORKDIR /x

# Add init system
RUN nix-env -iA nixpkgs.tini

# Use init system
ENTRYPOINT ["/usr/bin/env", "tini", "--" ]

# Copy required files for Nix operations
COPY default.nix .

# Build the cache of system dependencies
RUN nix-shell --run exit

# Copy everything else in
COPY . .

# Run the CI for all variants of the cookiecutter
CMD ["nix-shell", "--run", "make ci"]
