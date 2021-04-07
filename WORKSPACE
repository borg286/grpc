load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")



#====== GRPC  ==============

git_repository(
    name = "rules_proto_grpc",
    commit = "be97d01f3c8dda96a3ab688342b08de29ad2592b",
    remote = "https://github.com/rules-proto-grpc/rules_proto_grpc.git",
)

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_toolchains", "rules_proto_grpc_repos")
rules_proto_grpc_toolchains()
rules_proto_grpc_repos()

load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")

rules_proto_grpc_cpp_repos()


load("@rules_proto_grpc//:repositories.bzl", "bazel_gazelle", "io_bazel_rules_go")  # buildifier: disable=same-origin-load

io_bazel_rules_go()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(
    go_version = "1.15.8",
)

bazel_gazelle()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")

gazelle_dependencies()

load("@rules_proto_grpc//go:repositories.bzl", rules_proto_grpc_go_repos = "go_repos")

rules_proto_grpc_go_repos()

load("@rules_proto_grpc//java:repositories.bzl", rules_proto_grpc_java_repos = "java_repos")

rules_proto_grpc_java_repos()

load("@rules_proto_grpc//python:repositories.bzl", rules_proto_grpc_python_repos = "python_repos")

rules_proto_grpc_python_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@rules_python//python:pip.bzl", "pip_install")

pip_install(
    name = "rules_proto_grpc_py3_deps",
    python_interpreter = "python3",
    requirements = "@rules_proto_grpc//python:requirements.txt",
)



#=================================

RULES_JVM_EXTERNAL_TAG = "2.8"
RULES_JVM_EXTERNAL_SHA = "79c9850690d7614ecdb72d68394f994fef7534b292c4867ce5e7dec0aa7bdfad"

http_archive(
    name = "rules_jvm_external",
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    sha256 = RULES_JVM_EXTERNAL_SHA,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@io_grpc_grpc_java//:repositories.bzl", "IO_GRPC_GRPC_JAVA_ARTIFACTS", "IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS", "grpc_java_repositories")

maven_install(
    artifacts = IO_GRPC_GRPC_JAVA_ARTIFACTS + [
        # Imported from Redisson dependencies
        "org.redisson:redisson-all:3.13.3",
        "redis.clients:jedis:3.0.0",
        "org.slf4j:slf4j-api:1.7.25",
        "org.slf4j:slf4j-simple:1.7.25",
        "org.apache.commons:commons-pool2:2.4.3",
        "org.apache.commons:commons-lang3:3.11",
        #"io.netty:netty-tcnative-boringssl-static:2.0.31.Final",
        #"io.netty:netty-all:4.1.41.Final",

        # Flag library
        "com.github.pcj:google-options:jar:1.0.0",
        "com.google.code.gson:gson:2.8.5",
        "com.google.protobuf:protobuf-java-util:3.6.1",

        # Joda time
        "joda-time:joda-time:2.10",
    ],
    generate_compat_repositories = True,
    override_targets = IO_GRPC_GRPC_JAVA_OVERRIDE_TARGETS,
    repositories = [
        "https://repo.maven.apache.org/maven2/",
        "https://repo1.maven.org/maven2",
        "https://mvnrepository.com",
    ],
)

load("@maven//:compat.bzl", "compat_repositories")

compat_repositories()

grpc_java_repositories()



#=====Docker images======

# Download the rules_docker repository at release v0.12.1
http_archive(
    name = "io_bazel_rules_docker",
    strip_prefix = "rules_docker-0.16.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.16.0/rules_docker-v0.16.0.tar.gz"],
)


load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)
container_repositories()

# This is NOT needed when going through the language lang_image
# "repositories" function(s).
load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()



load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
)

container_pull(
  name = "java_base",
  registry = "gcr.io",
  repository = "distroless/java",
  # 'tag' is also supported, but digest is encouraged for reproducibility.
  digest = "sha256:deadbeef",
)
load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)
container_repositories()

load(
    "@io_bazel_rules_docker//go:image.bzl",
    _go_image_repos = "repositories",
)
_go_image_repos()


load(
    "@io_bazel_rules_docker//cc:image.bzl",
    _cc_image_repos = "repositories",
)
_cc_image_repos()


load(
    "@io_bazel_rules_docker//python:image.bzl",
    _py_image_repos = "repositories",
)
_py_image_repos()

load(
    "@io_bazel_rules_docker//java:image.bzl",
    _java_image_repos = "repositories",
)
_java_image_repos()


load("@io_bazel_rules_docker//container:container.bzl", "container_pull",)
container_pull(
    name = "redis-base",
    registry = "index.docker.io",
    repository = "redis",
    digest = "sha256:e73ef998c22f9a98793d9951bb2915cd945d8fa6f9ec1b324e85d19617efc2fd",
)

#====== END Docker images==========


#=======   K8S =======

# This requires rules_docker to be fully instantiated before
# it is pulled in.
# Download the rules_k8s repository at release v0.6
http_archive(
    name = "io_bazel_rules_k8s",
    strip_prefix = "rules_k8s-0.6",
    urls = ["https://github.com/bazelbuild/rules_k8s/archive/v0.6.tar.gz"],
    sha256 = "51f0977294699cd547e139ceff2396c32588575588678d2054da167691a227ef",
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")

k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s_go_deps.bzl", k8s_go_deps = "deps")

k8s_go_deps()

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_defaults")
load("//prod:cluster_consts.bzl", "REGISTRY", "CLUSTER", "PROJECT")

k8s_defaults(
  name = "k8s_deploy",
  cluster = CLUSTER,
  kind = "deployment",
)
k8s_defaults(
  name = "k8s_job",
  cluster = CLUSTER,
  kind = "job",
)

k8s_defaults(
  name = "k8s_object",
  cluster = CLUSTER,
)


#====== END K8S ======


#====== JSONNET  =====
# We use jsonnet to configure the kubernetes deployments, services...

git_repository(
    name = "io_bazel_rules_jsonnet",
    commit = "12979862ab51358a8a5753f5a4aa0658fec9d4af",
    remote = "https://github.com/bazelbuild/rules_jsonnet.git",
)

load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_repositories")

jsonnet_repositories()

http_archive(
    name = "kube_jsonnet",
    url = "https://github.com/bitnami-labs/kube-libsonnet/archive/96b30825c33b7286894c095be19b7b90687b1ede.tar.gz",
    strip_prefix = "kube-libsonnet-96b30825c33b7286894c095be19b7b90687b1ede",
    build_file_content = """
package(default_visibility = ["//visibility:public"])
load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_library")

jsonnet_library(
    name = "kube_lib",
    srcs = ["kube.libsonnet"],
)
""",
)
#======= END JSONNET  ======


go_repository(
    name = "gomodule_redigo",
    commit = "2cd21d9966bf7ff9ae091419744f0b3fb0fecace",
    importpath = "github.com/gomodule/redigo",
)
#======== Monitoring configs =====

new_git_repository(
    name = "monitoring",
    remote = "https://github.com/coreos/kube-prometheus.git",
    commit = "9493a1a5f7090dca406a0e80d1986484c70c1acf",
    build_file = "//prod:BUILD.yaml-extraction",
)


go_repository(
    name = "gojsontoyaml",
    commit = "3697ded27e8cfea8e547eb082ebfbde36f1b5ee6",
    importpath = "github.com/brancz/gojsontoyaml",
)

#======== End Monitoring configs ====
