# Bash Utils

Useful Bash scripts for ChainOps and more

## forge-inspect.sh

- `forge-inspect generate [CONTRACTS]`: Generate a storage layout file for your [CONTRACTS], which should be a space separated list. It is saved as `.storage-layout`
- `forge-inspect check [CONTRACTS]` : Check the current storage layout of the contracts against an existing `.storage-layout` file. If the two layouts are not identical, it will print the `diff` and exit with `exist code 1`
- Commit the storage layout to a Git repository and have the CI run `forge-inspect check`. If the check fails, that means that the storage layout changed. The developer will need to acknowledge that difference and commit the new storage layout for the test to pass

**Generate**

```bash
./forge-inspect generate Replica Home
Creating storage layout diagrams for the following contracts: Replica Home
...
Storage layout snapshot stored at .storage-layout
```

**Check**

```bash
./forge-inspect check Replica Home
storage-layout test: passes ✅
```

```bash
./forge-inspect check BridgeRouter
storage-layout test: fails ❌
The following lines are different:
21c21
< | xAppConnectionManager | contract XAppConnectionManager | 10  | 0      | 20    | packages/contracts-bridge/contracts/BridgeRouter.sol:BridgeRouter |
---
> | xAppConnectionManager | contract XAppConnectionManager | 101  | 0      | 20    | packages/contracts-bridge/contracts/BridgeRouter.sol:BridgeRouter |
```

## multi-anvil.sh

Spin up multiple [Anvil](https://book.getfoundry.sh/anvil/) instances in an instant.

- `CTRL+C` to terminate all of them at once.
- They spin up with incrementing port numbers, starting from `8545`
- Useful for multi-chain testing

## print-util.sh

Useful functions to nicely print messages.

- info
- warning
- announce

![](https://user-images.githubusercontent.com/13405632/181225169-93d8a075-1178-4e30-afda-4c0d12f8db34.png)

Useful variables to colour your terminal output

```
TPUT_RESET="$(tput sgr 0)"
TPUT_WHITE="$(tput setaf 7)"
TPUT_BGRED="$(tput setab 1)"
TPUT_BGGREEN="$(tput setab 2)"
TPUT_GREEN="$(tput setaf 2)"
TPUT_RED="$(tput setaf 1)"
TPUT_BOLD="$(tput bold)"
TPUT_DIM="$(tput dim)"
```

## License

MIT
