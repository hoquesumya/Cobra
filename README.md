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
