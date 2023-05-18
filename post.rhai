file::rename(".gen.envrc", ".envrc");
file::rename(".gen.gitignore", ".gitignore");
file::rename("README.gen.md", "README.md");
file::rename("flake.gen.nix", "flake.nix");

if !variable::get("use_default_licensing") {
    print("NOTE: remember to add license information in the initial commit!");
    file::delete("LICENSE.md");
    file::delete("LICENSE-Apache-2.0.md");
    file::delete("LICENSE-MIT.md");
}

let msg = "NOTE: remember to run `cd "
    + variable::get("project-name")
    + "` then read and run `./bin/init` to finish initial setup!";

print(msg);
