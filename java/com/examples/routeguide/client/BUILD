load("@io_bazel_rules_docker//java:image.bzl", "java_image")

java_image(
    name = "client-image",
    srcs = [
        "RouteGuideClient.java",
    ],
    main_class = "io.grpc.examples.routeguide.RouteGuideClient",
    resources = ["//java/com/examples/routeguide:route_guide_db.json"],
    deps = [
        "//java/com/examples/routeguide:routeguide",
        "//java/com/examples/routeguide:util",
    ],
)

