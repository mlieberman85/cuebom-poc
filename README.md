# Cuebom POC

This is intended as a test bed to see how we can use Cuelang to take data from various formats and convert them into standard SBOM formats.

This is purely a POC test bed so I won't be getting into too many details of how it works, now how to use it beyond the basics. If it turns out to make sense, I will create a new repo with standard tooling around it.

Note: This uses the schemas from CycloneDX's codebase: http://github.com/cycloneDX/specification/ and is included for the sake of making the POC easier. The cue files are based on the schemas from there with minimal changes.

## Nix derivation output json to CycloneDX

### Process

This process describes hwo to reimplement the functionality, which requires using cue cli and messing with some formatting and files to get it to work correctly.

1. Use cue cli to import CycloneDX json schema and conver to cuelang
   Something like: `cue import original_inputs/bom-1.3.schema.json`
2. You then have to turn the content into a struct. For some reason you can't use "-l" for a path expression due to it relying on the spdx license schema as well. Trying to figure out why that is. This is the workaround.
3. Create package structure for it, e.g. `cyclonedx`.
4. Run something like: `cue import -f -p cyclonedx -l '#spdxLicense:' original_inputs/spdx.schema.json`
5. You may have to make some modifications of the `bom-1.3.schema.cue` file due to it thinking there's an spdx project that includes your spdx license info, which it won't have. I will take a look to see if there's a way to simplify this.
6. Write cuelang code in another file like `convert_drv_to_cyclonedx.cue` that converts your desired format into CycloneDX using the library generated in the previous steps.

### How to use

1. Fetch json output of Nix derivation and save to file
2. Use cue cli to import Nix derivation json file and convert to cuelang with "drvs" path expression
   Something like: `cue import -f -l 'drvs:' original_inputs/drvs.json`
3. You can then run `cue eval drvs.cue convert_drv_to_cyclonedx.cue` --output json > sbom.json
