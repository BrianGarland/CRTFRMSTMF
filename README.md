# CRTFRMSTMF

CRTFRMSTMF is a wrapper over the IBM i CRTxxx compile commands that do not allow a stream file.

### Prerequisites

This uses the TGTCCSID parameter on CRTBNDRPG and therefore requires the PTF listed here:
[Compile RPG from Unicode source](https://www.ibm.com/support/pages/compile-rpg-unicode-source-new-tgtccsid-parameter-71-72-73)

### Installation 

1. `git clone` this repository
2. Run `gmake` (available from yum)

### Usage instructions

1. `ADDLIBLE CRTFRMSTMF` (or whatever library you used)
2. `CRTFRMSTMF` and prompt for parameters.  Command help is provided. 

### License

MIT License. See file `LICENSE` in root of this repository.
