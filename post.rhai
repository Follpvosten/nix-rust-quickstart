file::rename(".gen.gitignore", ".gitignore");
file::rename("README.gen.md", "README.md");
file::rename("bin/ci.gen", "bin/ci");
file::rename("flake.gen.nix", "flake.nix");

print("Note: if using git, flake-related files must be at least staged");
print("Note: the cargoSha256 in flake.nix must be manually updated");
print("Note: it's recommended to create an initial commit immediately");
