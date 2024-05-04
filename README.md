# Cobra 🐍

## Installing

```
git clone https://github.com/hoquesumya/Cobra.git
cd Cobra
make
```

## Getting Started

Locally:

```
./cobra < ./tests/full.🐍
```

In Docker:

```
docker build -t cobra .
docker run -v $(pwd)/tests:/app/tests cobra
```

Interactively:

```
docker run -v $(pwd)/tests:/app/tests -it cobra /bin/bash
./cobra < ./tests/full.🐍
```

## Testing

Validation is run against files in `./tests` which are then printed to stdout when successful.

If parsing fails the following error is thrown: `Fatal error: exception Stdlib.Parsing.Parse_error`

```
./test.sh
```

## Contributing

For more complete instructions on contributing to Cobra development, see the [Developer Guide](./CONTRIBUTING.md).

## Next Steps

* What we have but converted with IR gen + SAST
* More test cases
* Add classes + mem ops to scanning

- Sumya Class + Mem ops in scan + print.ml
- Vineeth SAST from nanoc to python
- Vidur IR gen from nanoc to python
- Baily Docker + tests + docs
