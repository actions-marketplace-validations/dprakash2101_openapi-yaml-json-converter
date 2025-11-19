# OpenAPI YAML to JSON Converter

![GitHub Marketplace](https://img.shields.io/badge/Marketplace-Action-blue?logo=github)

A reusable GitHub Action to **convert an OpenAPI YAML specification to JSON** and commit the updated JSON file back to your repository. Ideal for keeping your SDK generation or API tooling workflows up-to-date.

---

## Features

- Converts OpenAPI YAML to JSON using [`swagger-cli`](https://github.com/APIDevTools/swagger-cli)
- Validates and preserves OpenAPI specification structure
- Automatically commits and pushes changes to your repository
- Fully reusable across multiple repositories
- Supports custom GitHub username, email, and commit messages

---

## Usage

### Workflow example

```yaml
name: Update OpenAPI JSON

on:
  push:
    paths:
      - path/to/your/openapi-spec.yaml  # <-- replace with your YAML path

jobs:
  update_json:
    runs-on: ubuntu-latest
    steps:
      - name: Convert YAML to JSON
        uses: dprakash2101/openapi-yaml-json-converter@v1
        with:
          yaml_path: path/to/your/openapi-spec.yaml   # <-- replace with your YAML file
          json_path: path/to/your/openapi-spec.json   # <-- replace with desired JSON output
          git_username: ${{ secrets.ADMIN_USERNAME }}
          git_email: ${{ secrets.ADMIN_EMAIL }}
          commit_message: "Update OpenAPI JSON from YAML"
```

## Author

This action is created and maintained by [Devi Prakash](https://github.com/dprakash2101).

---

## License

This project is licensed under the **MIT License**.  

See the [LICENSE](LICENSE) file for details.
