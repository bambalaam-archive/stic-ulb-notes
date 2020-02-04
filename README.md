
# MA-STIC (ULB)

This repository holds my notes (in French, sorry 🤷 ) for courses at 
[Université Libre de Bruxelles](https://www.ulb.be) in the [Master in Information and Communication Science and technology](http://mastic.ulb.ac.be/) program.

## How to use

There are two (and a half) ways to use this repository:

### Normal

```
cd <your desired class directory>
pdflatex index.tex
```

### Docker

- Edit the `.env` file to pick which course you're currently working on

```
COURSE=<your desired class directory>
```

- Run the docker-compose file

```
docker-compose up
```

### Bonus: Docker + Rofi

If you're a cool person and you use Rofi, executing `./choose_course.sh`
allows you to pick and choose the course directory, instead of editing the
`.env` file.

![Rofi example](https://i.imgur.com/ytph7bR.png)

## Credit

The LaTeX structure (preamble, headers, `lecture` command, and others) are
largely inspired by [Gilles Castel's](https://github.com/gillescastel)
blogpost ["How I manage my LaTeX lecture notes"](https://castel.dev/post/lecture-notes-3/)
