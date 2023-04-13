dockerfile_specs = {
  "revdeps.Dockerfile" : {
    tag: "andrjohns/revdeps" ,
    build_args : ["PUID=990", "PGID=986"],
    platforms : "linux/amd64,linux/arm64"
  },
  "stan_triton.Dockerfile" : {
    tag: "andrjohns/stan_triton"
  },
  "nested/nested.Dockerfile" : {
    tag: "andrjohns/nested"
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
