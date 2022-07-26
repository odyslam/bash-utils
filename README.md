# Bash Utils

Useful util scripts for Bash

## forge-inspect.sh

- `forge-inspect generate [CONTRACTS]`: Generate a storage layout file for your [CONTRACTS], which should be a space separated list. It is saved as `.storage-layout`
- `forge-inspect check [CONTRACTS]` : Check the current storage layout of the contracts against an existing `.storage-layout` file. If the two layouts are not identical, it will print the `diff` and exit with `exist code 1`
- Commit the storage layout to a Git repository and have the CI run `forge-inspect check`. If the check fails, that means that the storage layout changed. The developer will need to acknowledge that difference and commit the new storage layout for the test to pass

**Generate**

```
./forge-inspect generate Replica Home
Creating storage layout diagrams for the following contracts: Replica Home
...
Storage layout snapshot stored at .storage-layout
```

**Check**

```
./forge-inspect check Replica Home
storage-layout test: passes ✅

```
