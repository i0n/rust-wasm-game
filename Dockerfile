FROM rust as builder

ARG DOCKER_ARG_VERSION
ARG DOCKER_ARG_REV
ARG DOCKER_ARG_BRANCH
ARG DOCKER_ARG_BUILD_USER

WORKDIR /app
COPY ./web /app
RUN cargo install basic-http-server

FROM gcr.io/distroless/cc as runtime
COPY --from=builder /usr/local/cargo/bin/basic-http-server /
COPY --from=builder /app /
EXPOSE 8000
CMD ["/basic-http-server", "-a", "0.0.0.0:8000"]
