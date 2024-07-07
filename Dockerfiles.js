dockerfile_specs = [
  {
    file: "revdeps.Dockerfile",
    tag: "andrjohns/revdeps",
    platforms : "linux/amd64,linux/arm64"
  },
  {
    file: "stan-triton.Dockerfile",
    tag: "andrjohns/stan-triton",
    platforms : "linux/amd64"
  },
  {
    file: "sem.Dockerfile",
    tag: "andrjohns/sem",
    platforms : "linux/amd64,linux/arm64"
  },
  {
    file: "opencl-triton.Dockerfile",
    tag: "andrjohns/opencl-triton",
    platforms : "linux/amd64"
  },
  {
    file: "opencl-triton-amd.Dockerfile",
    tag: "andrjohns/opencl-triton-amd",
    platforms : "linux/amd64"
  },
  {
    file: "vulkan-triton.Dockerfile",
    tag: "andrjohns/vulkan-triton",
    platforms : "linux/amd64"
  },
  {
    file: "rtools-build.Dockerfile",
    tag: "andrjohns/rtools-build",
    platforms : "linux/amd64,linux/arm64"
  },
  {
    file: "r-devel.Dockerfile",
    tag: "andrjohns/r-devel",
    platforms : "linux/amd64,linux/arm64"
  },
  {
    file: "quickjsr-cross-tests.Dockerfile",
    tag: "andrjohns/quickjsr-cross-386",
    platforms : "linux/386"
  },
  {
    file: "quickjsr-cross-tests.Dockerfile",
    tag: "andrjohns/quickjsr-cross-armel",
    platforms : "linux/arm/v5"
  },
  {
    file: "quickjsr-cross-tests.Dockerfile",
    tag: "andrjohns/quickjsr-cross-armhf",
    platforms : "linux/arm/v7"
  },
  {
    file: "quickjsr-cross-tests.Dockerfile",
    tag: "andrjohns/quickjsr-cross-mips64le",
    platforms : "linux/mips64le"
  },
  {
    file: "quickjsr-cross-tests.Dockerfile",
    tag: "andrjohns/quickjsr-cross-ppc64le",
    platforms : "linux/ppc64le"
  },
  {
    file: "quickjsr-cross-tests.Dockerfile",
    tag: "andrjohns/quickjsr-cross-riscv64",
    platforms : "linux/riscv64"
  },
  {
    file: "quickjsr-cross-tests.Dockerfile",
    tag: "andrjohns/quickjsr-cross-s390x",
    platforms : "linux/s390x"
  },
  {
    file: "flang-wasm.Dockerfile",
    tag: "andrjohns/flang-wasm",
    platforms : "linux/amd64,linux/arm64"
  },
  {
    file: "webr-build.Dockerfile",
    tag: "andrjohns/webr-build",
    platforms : "linux/amd64,linux/arm64"
  }
];

const build_args_matrix = function(dockerfile_list) {
  return {
    "include" : dockerfile_list.map(dockerfile => dockerfile_specs.filter(spec => spec.file === dockerfile))
  }
}

module.exports = build_args_matrix;
