ctags -f .tags --sort=yes -R --fields=+l --languages=python $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))") ./
