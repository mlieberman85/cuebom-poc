package main

import (
    //"strings"
    "github.com/mlieberman85/cuebom-poc/cyclonedx"
)

cyclonedx.#CycloneDXBom & {
	bomFormat: "CycloneDX"
    specVersion: "1.3"
    components: [
        for k, v in _drvs { 
            cyclonedx.#CycloneDXBom.#component & {
                // TODO: Once we figure out how to differentiate between the different component types,
                //       Change below depending on type like application and library.
                type: "file"

                // TODO: Include mime type

                "bom-ref": k

                name: v.env.name

                version: v.env.version | *"undefined"

                hashes: [
                    if v.outputs.out.hashAlgo != _|_ {
                        cyclonedx.#CycloneDXBom.#hash & {
                            if v.outputs.out.hashAlgo == "sha256" {
                                //alg: {
                                //    _t: strings.ToUpper(v.outputs.out.hashAlgo)
                                //    strings.SliceRunes(_t, 0, 3) + "-" + strings.SliceRunes(_t, 3, len(_t))
                                //}
                                alg: "SHA-256"
                            }
                            // FIXME: Below probably isn't right, this is a recursive sha-256
                            if v.outputs.out.hashAlgo == "r:sha256" {
                                alg: "SHA-256"
                            }
                            content: v.outputs.out.hash
                        }
                    }
                ]
            }
        }
    ]
    dependencies: [
        for k, v in _drvs { 
            cyclonedx.#CycloneDXBom.#dependency & {
                ref: k
                dependsOn: [
                    for dep_k, dep_v in v.inputDrvs {dep_k}
                ]
            }
        }
    ]
}

