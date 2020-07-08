# Generic Cloud development environment
Run command(s):
```bash
alias cloud-dev='docker run -it -v $HOME/.ssh:/home/dev/.ssh -v $(pwd):/home/dev/workdir/$(basename $(pwd)) -u $(id -u):$(id -g) cloud-dev'
```
