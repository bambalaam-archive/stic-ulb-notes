
# MA-STIC (ULB)

This repository holds my notes (in French, sorry 🤷 ) for courses at 
[Université Libre de Bruxelles](https://www.ulb.be) in the [Master in Information and Communication Science and technology](http://mastic.ulb.ac.be/) program.

## How to use

There are three ways to use this repository:

### Docker + Rofi

If you're a cool person and you use Rofi, executing `./courses_script.sh`
allows you to do many fancy things:

- Pick and choose the course directory, instead of editing the `.env` file
- Open the active course in Sublime Text, a terminal, and the resulting PDF (TODO: make editor, terminal emulator and others configurable)
- Create new lecture in the active course (this creates a new file in the `/lectures` directory and auto-adds it to the `index.tex` file of the course)

![Rofi example](https://i.imgur.com/BsAvmOe.png)

### Simply Docker

- Edit the `.env` file to pick which course you're currently working on

```
COURSE=<your desired class directory>
```

- Run the docker-compose file

```
docker-compose up
```

### Normal

```
cd <your desired class directory>
pdflatex index.tex
```

## Credit

The LaTeX structure (preamble, headers, `lecture` command, and others) are
largely inspired by [Gilles Castel's](https://github.com/gillescastel)
blogpost ["How I manage my LaTeX lecture notes"](https://castel.dev/post/lecture-notes-3/). May he Rest In Peace.
