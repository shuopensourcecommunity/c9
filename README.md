# Cloud9 IDE DOckerlize

The project is based on [z3cka/c9](https://github.com/z3cka/c9) and [shuosc/ubuntu](https://hub.docker.com/r/shuosc/ubuntu/) images.

## FEATURES

- Support user authorization
- Include zsh
- Use China local Ubuntu and Pypi Mirror

## HOW TO USE

```bash
docker run -d -p 80:80 -e user=c9 -e pass=rules shuosc/c9:latest
```