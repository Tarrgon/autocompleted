FROM rust:1.68-alpine3.17 as builder

WORKDIR /app

RUN apk add --no-cache musl-dev

COPY . .

RUN CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse cargo build --release

FROM alpine:3.17

COPY --from=builder /app/target/release/autocompleted /app/autocompleted
