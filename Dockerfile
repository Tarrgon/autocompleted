FROM rust:1.70-alpine3.18 as builder

WORKDIR /app

RUN apk add --no-cache musl-dev

COPY . .

RUN cargo build --release

FROM alpine:3.18

COPY --from=builder /app/target/release/autocompleted /app/autocompleted
