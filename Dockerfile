FROM rust:1.95.0-alpine3.22 as builder

WORKDIR /app

RUN apk add --no-cache musl-dev

COPY . .

RUN cargo build --release

FROM alpine:3.22

COPY --from=builder /app/target/release/autocompleted /app/autocompleted
