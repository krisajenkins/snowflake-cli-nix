# Agent Instructions

## Updating snowflake-cli

When updating the snowflake-cli version, you must also check and update the dependency overlays to match the pinned versions in the CLI's `pyproject.toml`.

### Finding Pinned Dependency Versions

The snowflake-cli pins exact versions of its dependencies in `pyproject.toml`. To find the required versions:

1. Fetch the `pyproject.toml` for the target CLI version:
   ```
   https://raw.githubusercontent.com/snowflakedb/snowflake-cli/v<VERSION>/pyproject.toml
   ```

2. Look at the `dependencies` section for the pinned versions:
   - `snowflake-connector-python[secure-local-storage]==X.Y.Z`
   - `snowflake.core==X.Y.Z`
   - `snowflake-snowpark-python==X.Y.Z`
   - `id==X.Y.Z`

### Overlay Files to Update

| Dependency | Overlay File |
|------------|--------------|
| snowflake-cli | `overlays/snowflake-cli.nix` |
| snowflake-connector-python | `overlays/snowflake-connector-python.nix` |
| snowflake.core | `overlays/snowflake-core.nix` |
| snowflake-snowpark-python | `overlays/snowflake-snowpark-python.nix` |
| id | `overlays/python-id.nix` |

### Fetching Hashes

Each overlay file contains a comment with instructions for fetching the hash. Generally:

- For GitHub sources: `nix-prefetch-url --unpack https://github.com/<owner>/<repo>/archive/refs/tags/v<VERSION>.tar.gz`
- For PyPI sources: `nix-prefetch-url https://files.pythonhosted.org/packages/source/<first-letter>/<package>/<package>-<VERSION>.tar.gz`

Then convert to SRI format: `nix hash convert --hash-algo sha256 --to sri <hash>`
