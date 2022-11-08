file::rename(".gen.envrc", ".envrc");
file::rename(".gen.gitignore", ".gitignore");
file::rename("README.gen.md", "README.md");
file::rename("flake.gen.nix", "flake.nix");

print("NOTE: remember to read and run `./bin/init` to finish initial setup!");
