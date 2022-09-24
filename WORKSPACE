load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")



#====== GRPC  ==============

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "rules_python",
    sha256 = "cdf6b84084aad8f10bf20b46b77cb48d83c319ebe6458a18e9d2cebf57807cdd",
    strip_prefix = "rules_python-0.8.1",
    url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/0.8.1.tar.gz",
)

#load("@rules_python//python:repositories.bzl", "python_register_toolchains")

#python_register_toolchains(
#  name = "python3_9",
#  python_version = "3.9",
#)

#new_local_repository(
#    name = "python_linux",
#    path = "/usr",
#    build_file_content = """
#cc_library(
#    name = "python39-lib",
#    srcs = ["lib/lib/python3.9/config-3.9-x86_64-linux-gnu/libpython3.9.so"],
#    hdrs = glob(["include/python3.9/*.h"]),
#    includes = ["include/python3.9"],
#    visibility = ["//visibility:public"]
#)
#    """
#)

#load("@python3_9//:defs.bzl", "interpreter")



_configure_python_based_on_os = """
if [[ "$OSTYPE" == "darwin"* ]]; then
    ./configure --prefix=$(pwd)/bazel_install --with-openssl=$(brew --prefix openssl)
else
    ./configure --prefix=$(pwd)/bazel_install
fi
"""

# Fetch Python and build it from scratch
http_archive(
    name = "python_interpreter",
    build_file_content = """
exports_files(["python_bin"])
filegroup(
    name = "files",
    srcs = glob(["bazel_install/**"], exclude = ["**/* *"]),
    visibility = ["//visibility:public"],
)
""",
    patch_cmds = [
        "mkdir $(pwd)/bazel_install",
        _configure_python_based_on_os,
        "make",
        "make install",
        "ln -s bazel_install/bin/python3 python_bin",
    ],
    sha256 = "dfab5ec723c218082fe3d5d7ae17ecbdebffa9a1aea4d64aa3a2ecdd2e795864",
    strip_prefix = "Python-3.8.3",
    urls = ["https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tar.xz"],
)

# Fetch official Python rules for Bazel
http_archive(
    name = "rules_python",
    sha256 = "b6d46438523a3ec0f3cead544190ee13223a52f6a6765a29eae7b7cc24cc83a0",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.1.0/rules_python-0.1.0.tar.gz",
)

load("@rules_python//python:repositories.bzl", "py_repositories")

py_repositories()



load("@rules_python//python:pip.bzl", "pip_install")

pip_install(
  name = "py_deps",
  python_interpreter_target = "@python_interpreter//:python_bin",
  requirements = "//python:requirements.txt",
  quiet = False,
  #environment = {"GRPC_PYTHON_BUILD_SYSTEM_ZLIB": "true"},
)

# The Python toolchain must be registered ALWAYS at the end of the file
register_toolchains("//:py_3_toolchain")

http_archive(
    name = "rules_proto_grpc",
    sha256 = "507e38c8d95c7efa4f3b1c0595a8e8f139c885cb41a76cab7e20e4e67ae87731",
    strip_prefix = "rules_proto_grpc-4.1.1",
    urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/archive/4.1.1.tar.gz"],
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

        #Prometheus exporter
        "io.prometheus:simpleclient:0.15.0",
        "io.prometheus:simpleclient_hotspot:0.15.0",
        "io.prometheus:simpleclient_httpserver:0.15.0",
        "io.prometheus:simpleclient_pushgateway:0.15.0",
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

# Download the rules_docker repository at release v0.24.0
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "27d53c1d646fc9537a70427ad7b034734d08a9c38924cc6357cc973fed300820",
    strip_prefix = "rules_docker-0.24.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.24.0/rules_docker-v0.24.0.tar.gz"],
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
    "@io_bazel_rules_docker//python3:image.bzl",
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


new_git_repository(
    name = "redis_exporter",
    commit = "7af6f7462a0d2477eb24ba2a093de4cf6f8df995",
    remote = "https://github.com/oliver006/redis_exporter.git",
    build_file_content = """exports_files(glob(["**/*.json",]))""",
    shallow_since = "1649901819 -0400",
)



#=======   K8S =======

# This requires rules_docker to be fully instantiated before
# it is pulled in.
# Download the rules_k8s repository at release v0.6

git_repository(
    name = "io_bazel_rules_k8s",
    commit = "d05cbea5c56738ef02c667c10951294928a1d64a",
    remote = "https://github.com/bazelbuild/rules_k8s.git",
    shallow_since = "1634602559 -0700",
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


http_archive(
    name = "io_bazel_rules_jsonnet",
    sha256 = "d20270872ba8d4c108edecc9581e2bb7f320afab71f8caa2f6394b5202e8a2c3",
    strip_prefix = "rules_jsonnet-0.4.0",
    urls = ["https://github.com/bazelbuild/rules_jsonnet/archive/0.4.0.tar.gz"],
)

load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_repositories")

jsonnet_repositories()

load("@google_jsonnet_go//bazel:repositories.bzl", "jsonnet_go_repositories")

jsonnet_go_repositories()

load("@google_jsonnet_go//bazel:deps.bzl", "jsonnet_go_dependencies")

jsonnet_go_dependencies()

http_archive(
    name = "kube_jsonnet",
    url = "https://github.com/bitnami-labs/kube-libsonnet/archive/d0c4e7ed559c880499efcafc76ee51adfc62eaeb.tar.gz",
    sha256 = "23555e0c27a85da2a7110b11143f9f5fc9cb4b046390b0f2ac8374a0c98c2e19",
    strip_prefix = "kube-libsonnet-d0c4e7ed559c880499efcafc76ee51adfc62eaeb",
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
    shallow_since = "1621930317 +0100",
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