load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")



#====== GRPC  ==============


http_archive(
    name = "rules_proto_grpc",
    sha256 = "28724736b7ff49a48cb4b2b8cfa373f89edfcb9e8e492a8d5ab60aa3459314c8",
    strip_prefix = "rules_proto_grpc-4.0.1",
    urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/archive/4.0.1.tar.gz"],
)

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_toolchains", "rules_proto_grpc_repos")
rules_proto_grpc_toolchains()
rules_proto_grpc_repos()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
rules_proto_dependencies()
rules_proto_toolchains()

load("@rules_proto_grpc//cpp:repositories.bzl", rules_proto_grpc_cpp_repos = "cpp_repos")

rules_proto_grpc_cpp_repos()


load("@rules_proto_grpc//:repositories.bzl", "bazel_gazelle", "io_bazel_rules_go")  # buildifier: disable=same-origin-load

io_bazel_rules_go()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(
    version = "1.17.1",
)

bazel_gazelle()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")

gazelle_dependencies()

load("@rules_proto_grpc//go:repositories.bzl", rules_proto_grpc_go_repos = "go_repos")

rules_proto_grpc_go_repos()

load("@rules_proto_grpc//java:repositories.bzl", rules_proto_grpc_java_repos = "java_repos")

rules_proto_grpc_java_repos()

load("@rules_jvm_external//:defs.bzl", "maven_install")

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
        #"https://repo.maven.apache.org/maven2/",
        "https://repo1.maven.org/maven2",
        #"https://mvnrepository.com",
        "https://maven.google.com",

    ],
)


load("@maven//:compat.bzl", "compat_repositories")

compat_repositories()

grpc_java_repositories()


#=====Docker images======

# Download the rules_docker repository at release v0.12.1
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "92779d3445e7bdc79b961030b996cb0c91820ade7ffa7edca69273f404b085d5",
    strip_prefix = "rules_docker-0.20.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.20.0/rules_docker-v0.20.0.tar.gz"],
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

git_repository(
    name = "io_bazel_rules_k8s",
    commit = "d05cbea5c56738ef02c667c10951294928a1d64a",
    remote = "https://github.com/bazelbuild/rules_k8s.git",
)


load("@io_bazel_rules_k8s//toolchains/kubectl:kubectl_configure.bzl", "kubectl_configure")
# Download the v1.10.0 kubectl binary for the Linux x86 64 bit platform.
http_file(
    name="k8s_binary",
    downloaded_file_path = "kubectl",
    #sha256="49f7e5791d7cd91009c728eb4dc1dbf9ee1ae6a881be6b970e631116065384c3",
    executable=True,
    urls=["https://dl.k8s.io/release/v1.22.3/bin/linux/amd64/kubectl"],
)
# Configure the kubectl toolchain to use the downloaded prebuilt v1.10.0
# kubectl binary.
kubectl_configure(name="k8s_config", kubectl_path="@k8s_binary//file")

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
    sha256 = "2a3a4f1686ba801b4697613a3132710eb7bbe40685b23df9677318835a3c7dac",
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


#======== Monitoring configs =====

# For each jsonnet or libsonnet file
# use PWD to try and figure out the name of the repo we are working on
# use dirname to figure out the path from the top directory down to where the jsonnet/libsonnet file is
# Use awk to look for import 'github.com/somerepo/subdir  and replace with import 'export somerepo/...'
# and replace import 'subdir/whatever' with import 'external/<directory down to this point>/subdir/whatever'
patch_json_repo = r"""
    for f in $(find . -name "*.jsonnet" -o -name "*.libsonnet"); 
        do awk -v prefix="${PWD##*/}/$(dirname $f)/"  '{if ( $0 ~ /github/ ) { sub(/import '\''github.com\/[^\/]*/,"import'\''external") } else { sub(/import '\''/,"import '\''external/" prefix) }; sub("(import '\''external/kubernetes-mixin/./dashboards/dashboards.libsonnet'\'') +","") ;  print }' $f > tmp; mv tmp $f
    done
    """

new_git_repository(
    name = "kube-prometheus",
    remote = "https://github.com/prometheus-operator/kube-prometheus.git",
    commit = "8396c697fdaca6e9c61954f3c075c0bc40e4a76b",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1623887898 -0300",    
)




go_repository(
    name = "gojsontoyaml",
    commit = "3697ded27e8cfea8e547eb082ebfbde36f1b5ee6",
    importpath = "github.com/brancz/gojsontoyaml",
)

# Note that the name of the build rule ends up as the top level directory name after external.
# So make sure the name matches what github would create as a top level folder.
new_git_repository(
    name = "prometheus-operator",
    remote = "https://github.com/prometheus-operator/prometheus-operator.git",
    commit = "05a8e6f8ccc249e9efc6774c1f822d5298d66c0d",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1623838634 +0200",
)

new_git_repository(
    name = "kube-state-metrics",
    remote = "https://github.com/kubernetes/kube-state-metrics.git",
    commit = "95500e51a3144659522df603ed4e7ee7f597bc3b",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1623072520 -0700",
)

new_git_repository(
    name = "grafonnet",
    remote = "https://github.com/grafana/dashboard-spec.git",
    commit = "f6b5fb6346fccf028044e8e8f6b66aacbe8bc9df",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
)

new_git_repository(
    name = "kubernetes-mixin",
    remote = "https://github.com/kubernetes-monitoring/kubernetes-mixin.git",
    commit = "aead52cf40f07c39794d20cc17ed08343e8ece01",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1623935087 +0200"
)
new_git_repository(
    name = "alertmanager",
    remote = "https://github.com/prometheus/alertmanager.git",
    commit = "58169c14126074bf45cce3e168641ede9eb23e47",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1623674900 +0200"
)
new_git_repository(
    name = "kubernetes-grafana",
    remote = "https://github.com/brancz/kubernetes-grafana.git",
    commit = "8ea4e7bc04b1bf5e9bd99918ca28c6271b42be0e",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1612196407 +0100"
)
new_git_repository(
    name = "node_exporter",
    remote = "https://github.com/prometheus/node_exporter.git",
    commit = "8edd27baaf0cd4e443ab556329fa0f8c3b2b02a0",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1623931568 +0200"
)
new_git_repository(
    name = "prometheus",
    remote = "https://github.com/prometheus/prometheus.git",
    commit = "60918b8415d928363ea4bc766d450e707035abe0",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1623937011 +0200"
)
new_git_repository(
    name = "grafonnet-lib",
    remote = "https://github.com/grafana/grafonnet-lib.git",
    commit = "3082bfca110166cd69533fa3c0875fdb1b68c329",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
)
new_git_repository(
    name = "jsonnet-libs",
    remote = "https://github.com/grafana/jsonnet-libs.git",
    commit = "eac3c4cf1c2d38dc11d63b6acbda3c8b455ab712",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1623936507 +0200"
)

#======== End Monitoring configs ====

#======= END JSONNET  ======


go_repository(
    name = "gomodule_redigo",
    commit = "2cd21d9966bf7ff9ae091419744f0b3fb0fecace",
    importpath = "github.com/gomodule/redigo",
)

http_file(
    name = "k3s",
    urls = ["https://github.com/k3s-io/k3s/releases/download/v1.19.10%2Bk3s1/k3s"],
    sha256 = "740451d8914477d4917338f55a321ad34af75dc59782b387088b8c1a3d33d607",
    executable = True,
)