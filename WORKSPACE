load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")



#====== GRPC  ==============

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

_configure_python_based_on_os = """
if [[ "$OSTYPE" == "darwin"* ]]; then
    ./configure --prefix=$(pwd)/bazel_install --with-openssl=$(brew --prefix openssl)
else
    ./configure --prefix=$(pwd)/bazel_install
fi
"""

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
  requirements = "//python:requirements.txt",
  quiet = False,
  #environment = {"GRPC_PYTHON_BUILD_SYSTEM_ZLIB": "true"},
)


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

go_repository(
    name = "gomodule_redigo",
    commit = "2cd21d9966bf7ff9ae091419744f0b3fb0fecace",
    importpath = "github.com/gomodule/redigo",
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
    commit = "5b28779e7ded6bd6eed223006c364e514e3c9913",
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
    commit = "12402a564cbf4557763079ab8e6e995d9afb4db9",
    build_file = "//prod/monitoring:BUILD.generic",
    shallow_since = "1663939105 -0700",
    patch_cmds = [patch_json_repo],
)

new_git_repository(
    name = "grafonnet",
    remote = "https://github.com/grafana/dashboard-spec.git",
    commit = "0090a6415a9674e7716a6e08d129501a8c398d98",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
)

new_git_repository(
    name = "kubernetes-mixin",
    remote = "https://github.com/kubernetes-monitoring/kubernetes-mixin.git",
    commit = "5e44626d70c2bf2d35c37f3fee5a6261a5335cc6",
    build_file = "//prod/monitoring:BUILD.generic",
    shallow_since = "1663065655 +0300",
    patch_cmds = [patch_json_repo],
)
new_git_repository(
    name = "alertmanager",
    remote = "https://github.com/prometheus/alertmanager.git",
    commit = "33a0e77a7143fd0795ee20f2e45bbdfffb2dbbbb",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1663850717 +0200",
)
new_git_repository(
    name = "kubernetes-grafana",
    remote = "https://github.com/brancz/kubernetes-grafana.git",
    commit = "d039275e4916aceae1c137120882e01d857787ac",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1649065985 +0200",
)
new_git_repository(
    name = "node_exporter",
    remote = "https://github.com/prometheus/node_exporter.git",
    commit = "e0845a81fd99c32aa227f78bfddf6a74f3fec98d",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1664003803 +0200",
)
new_git_repository(
    name = "prometheus",
    remote = "https://github.com/prometheus/prometheus.git",
    commit = "734772f82824db11344ea3c39a166449d0e7e468",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1663834906 +0200",
)
new_git_repository(
    name = "grafonnet-lib",
    remote = "https://github.com/grafana/grafonnet-lib.git",
    commit = "30280196507e0fe6fa978a3e0eaca3a62844f817",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1657001913 +0100",
)
new_git_repository(
    name = "grafana",
    remote = "https://github.com/grafana/grafana.git",
    commit = "f8bde4df09ea8449693f0ed63bab9d4ef5179d63",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
)
new_git_repository(
    name = "jsonnet-libs",
    remote = "https://github.com/grafana/jsonnet-libs.git",
    commit = "351bfae3eee23db305597f272ef29ec16f99ee49",
    build_file = "//prod/monitoring:BUILD.generic",
    patch_cmds = [patch_json_repo],
    shallow_since = "1663667259 +0200",
)

#======== End Monitoring configs ====

#======= END JSONNET  ======


#========  Helm Charts =====

git_repository(
    name = "com_github_masmovil_bazel_rules",
    # tag = "0.2.2",
    commit = "7bd160b5fe0354052e98b1dfb0cc6c4300b58026",
    remote = "https://github.com/masmovil/bazel-rules.git",
    shallow_since = "1656496458 +0200",
)

load(
    "@com_github_masmovil_bazel_rules//repositories:repositories.bzl",
    mm_repositories = "repositories",
)
mm_repositories()


# Istio
http_archive(
    name = "istio_gateway",
    build_file = "//prod/istio:BUILD.istio",
    sha256 = "17206af64f9e580ac4f901006737e1dfadbda9cf54211f2143529f92e111dbc0",
    url = "https://istio-release.storage.googleapis.com/charts/gateway-1.15.1.tgz",
    type = "tgz",
    strip_prefix = "gateway",
)

#======= END Helm  ======