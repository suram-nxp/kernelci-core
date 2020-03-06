## `kci_build`

The `kci_build` tool is used to do all the KernelCI steps related to building
kernels: getting the source, creating the config file, building the binaries,
generating meta-data files and pushing the files to a storage server.  The
['build-configs.yaml'](https://github.com/kernelci/kernelci-core/blob/master/build-configs.yaml)
file contains the definitions of what should be built (branches) and how
(compilers, architectures, kernel configurations).

For example, to to build a kernel locally from
[`linux-next`](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git)
which is the `next` build configuration in `build-configs.yaml`:

### 1. Optional: set up a local mirror
If you already have a linux check out:
```
git clone \
  --mirror git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
  --reference=~/src/linux linux-mirror.git
```
Then to update the mirror, or create it if you skipped the command above:

```
./kci_build update_mirror --config=next --mirror=linux-mirror.git
```

### 2. Create a local check-out (or update an existing one)
```
./kci_build update_repo --config=next --kdir=linux --mirror=linux-mirror.git
```
Optionally, to generate additional config fragments (e.g. to then build `defconfig+kselftest`):
```
./kci_build generate_fragments --config=next --kdir=linux
```

### 3. Build the kernel with defconfig
```
./kci_build build_kernel \
  --defconfig=defconfig --arch=x86 --build-env=gcc-8 --kdir=linux
```

To see the compiler output, add `--verbose`.
The output can be found in `linux/build`.

To build again without regenerating the kernel config file, just omit the
`--defconfig` argument:
```
./kci_build build_kernel \
  --arch=x86 --build-env=gcc-8 --kdir=linux
```

Note: the `build-env` option is only used to populate the meta-data for the
KernelCI database, it is not downloading a build environment.  A future
improvement would be to enable using a Docker image as with Jenkins builds
(`jenkins/build.jpl`).

### 4. Install the kernel binaries in a local directory
```
./kci_build install_kernel --config=next --kdir=linux
```

See the output in `linux/_install_`.

### 5. Optional: publish the kernel build

If you have a `kernelci-backend` instance running, you can send the kernel and
also the meta-data with these commands:
```
./kci_build push_kernel \
  --kdir=linux --api=https://localhost:12345 --token=1234-5678
./kci_build publish_kernel \
  --kdir=linux --api=https://localhost:12345 --token=1234-5678
```

Alternatively, to store the meta-data locally in a JSON file:
```
./kci_build publish_kernel --kdir=linux --json-path=build-meta.json
```
