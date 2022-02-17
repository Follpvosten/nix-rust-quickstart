# `{{project-name}}`

{{short_description}}

---

## Development

### Requirements

1. Install [Nix][nix] and enable support for [flakes][flakes]
2. Install [direnv][direnv] and [nix-direnv][nix-direnv]

[nix]: https://nixos.org/download.html
[flakes]: https://nixos.wiki/wiki/Flakes#Installing_flakes
[direnv]: https://direnv.net/docs/installation.html
[nix-direnv]: https://github.com/nix-community/nix-direnv#installation

## License

{% if license == "MIT OR Apache-2.0" -%}
This project is licensed under either of

* `Apache-2.0` ([file](LICENSE-Apache-2.0.md) or
  [online](http://www.apache.org/licenses/LICENSE-2.0))

* `MIT` ([file](LICENSE-MIT.md) or [online](http://opensource.org/licenses/MIT))

at your option.

{%- elsif license == "AGPL-3.0-only" -%}

This project is licensed under `AGPL-3.0-only` ([file](LICENSE-AGPL-3.0-only.md)
or [online](https://www.gnu.org/licenses/agpl-3.0.en.html)).
{%- endif %}
