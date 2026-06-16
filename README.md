# Central Contract Repository for the Order API

## What is Central Contract Repository?

Please see **[Documentation](https://specmatic.io/documentation/central_contract_repository.html)**

---

This repository serves as the Central Contract Repository for the following API Specifications / Contracts 
* OpenAPI
* GraphQL
* gRPC
* Async API

These contracts govern interactions between sample applications which you can find here
* [Sample Projects](https://specmatic.io/documentation/sample_projects.html)

## Backward Compatibility Testing

Backward compatibility between API specifications is now automatically checked using our GitHub Actions workflow. This ensures that changes in your branch are compatible with the main branch before merging.

### How it works:

1. When you push changes to a branch or create a pull request targeting the main branch, the CI workflow is triggered.
2. The workflow identifies changed API specification files (YAML, JSON, and GraphQL).
3. For changed OpenAPI specifications, it runs a backward compatibility check using the Specmatic.
4. For changed GraphQL schemas, it performs a similar check using the Specmatic GraphQL.

## Linting

Below is the instruction to run the OpenAPI linter on your local machine. It lints every OpenAPI spec under `io/**/openapi` using the recommended ruleset from `specmatic-linter.yaml`.

```
SPECS=$(find io -path '*/openapi/*' -type f \( -name '*.yaml' -o -name '*.yml' \) | xargs grep -lE '^(openapi|swagger):')
docker run --rm \
  -v "$(pwd):/usr/src/app" \
  -v "$HOME/.specmatic:/root/.specmatic:ro" \
  -w /usr/src/app \
  specmatic/enterprise \
  lint $SPECS --config specmatic-linter.yaml
```
