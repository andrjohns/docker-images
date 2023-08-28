dockerfile_specs = {
  "revdeps.Dockerfile" : {
    tag: "andrjohns/revdeps",
    platforms : "linux/amd64,linux/arm64"
  },
  "stan-triton.Dockerfile" : {
    tag: "andrjohns/stan-triton",
    platforms : "linux/amd64"
  },
  "sem.Dockerfile" : {
    tag: "andrjohns/sem",
    platforms : "linux/amd64,linux/arm64"
  },
  "opencl-triton.Dockerfile" : {
    tag: "andrjohns/opencl-triton",
    platforms : "linux/amd64"
  },
  "opencl-triton-amd.Dockerfile" : {
    tag: "andrjohns/opencl-triton",
    platforms : "linux/amd64"
  },
  "vulkan-triton.Dockerfile" : {
    tag: "andrjohns/vulkan-triton",
    platforms : "linux/amd64"
  }
};

const build_args_matrix = function(dockerfile_list) {
  return {
    "include" : dockerfile_list.map(dockerfile => {
                                      return {
                                        file : dockerfile,
                                        tag : dockerfile_specs[dockerfile].tag,
                                        build_args : dockerfile_specs[dockerfile].build_args,
                                        platforms : dockerfile_specs[dockerfile].platforms
                                      }
                                    })
  }
}

module.exports = build_args_matrix;
