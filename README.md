# Prepare MacOS machine

This action tries to clean up the GHA MacOS runner and make it sort of like CRAN.

## Caching

Caching on MacOS seems much slower than Linux, probably because MacOS does not run on Azure. We could consider just disabling it, downloading assets directly is almost just as fast, but perhaps less reliable.

Order: one issue with caching `/opt/R/x86_64` is that base-R also installs some stuff in there (TCL files). As a result, restoring cache will error if we do it after `setup-r` because those TCL files already exist and `actions/cache` does not `tar --overwrite`.

The `actions/cache` calls zstd executables compression. So we need to a static zstd after we have removed homebrew, otherwise the cache can't get stored. Update: the latest version of cranlibs has a copy of zstd now.
