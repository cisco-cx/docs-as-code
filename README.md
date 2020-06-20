# Docs as Code

This is an example repo to enable Engineers to create documentation using markdown for text and PlantUML or Graphviz for drawings.  Those files are "compiled" to other formats (especially PDF).  The compiling tools are dockerized and automatically installed on first use.  You should not need to install anything other than docker.  Makefiles and Docker do all the work for you.

## This is a TEMPLATE repo 

If you are creating a new repo for a documentation project, click the "Use this Template" to create a new repo.  

![Screen Shot](/images/screen-shot.png)

You must rename that repo.  This is not a fork, it's just a way to start with the same repo as a template for your work.  This is probably what you want to do.

## Creating a New Document

### New Document

First, create a new folder for your document source in the root directory of this repository and copy the example into it.  Edit the makefile in that folder to match your new document name and then edit the source in that folder for your new document.

```
cp -R example-template new-document-name
cd new-document-name
<edit Makefile so OUT_NAME := example-template becomes OUT_NAME := new-document-name>
<edit new-document-name/main.md to add your own data - use includes to add new chapters>
<edit new-document-name/chapter1.md to have your own content>
etc.
```
The examples provide a good start and include both a PlantUML and a Graphviz example.

## Building Docs

All currently built PDF documents are found in the `dist` directory. Changes to the `dist` directory should always be in their own commit. You should choose whether you will exclude files in dist by using .gitignore if you desire users to build docs themselves each time.

### Rebuilding current doc

To build, just:

```
make dist
```

Inspect the `dist` directory afterward.

## Document Formats

We chose markdown for the general documents and [PlantUML](https://plantuml.com/) and [Graphviz](https://www.graphviz.org/doc/info/shapes.html) for diagrams.  Documents are basically passed through [pp](http://christophe.delord.free.fr/pp/) and then through [pandoc](https://pandoc.org/). 


## General Usage

```
$ make
build                          Build all doc directories
clean                          Clean all doc directories
dist                           Build all doc pdfs and copy them to ./dist directory
help                           Print list of Makefile targets
```

## Usage

The [repo](https://github.com/cisco-cx/docs-as-code) is a "template" repository. All you have to do is click the green "Use this template" button and instead of forking you can
make a totally new repository using it as a template. You can then just work in that new repo.

There's an example-template folder with a good working example.  The overall template is in common/pandoc/templates but the default is pretty usable. You will want to make your
own logo and drop it into common/images instead of the very ugly generic logo that we put there as a placeholder.

### Change the title in the Makefile

To change the title of the output document, change the OUT_NAME in the Makefile:

```
OUT_NAME := example-template
DIR_NAME := $(PWD)

include ../common/Makefile
```

### Setting the Document Attributes

To change the title, subtitle, and to control the various document attributes you can edit the "pp" directives in the main.md file:

```
---
title: The Title
subtitle: 0.1.0 - Confidentiality Statement Goes Here
author: ["First Author1", "Second Author2"]
titlepage: true
toc-title: Table of Contents
logo: ../common/images/logo.pdf
listings-disable-line-numbers: true
footer-left: 'Confidentiality Statement Goes Here'
!bash
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "date: Build Date $(date --iso-8601=date)"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
```

## Tips in General

Some people craft the first version of their diagrams in other tools and then paste them into thier doc.  This [tool](http://magjac.com/graphviz-visual-editor/) is a powerful online WYSIWYG editor that is open source and you can host it yourself.


## Tips for WYSIWYG Editing (on a Mac)

Developers like the "edit-compile-test" loop which is not hard to do.  You can edit the source in one window using your favorite Editor that supports WYSIWYG (MacDown, Visual Studio Code) but seeing the drawings can require more work.  You can set up a local PlantUML server (instructions are easily findable with Google) but there is an easier way.

Edit the source in one window however you please.  Have a terminal open to the source repository root.  Use this to type "make dist" to compile to document to a PDF.

Have your output document open with your PDF output document (in the root dist folder).  When your compile is complete switch focus to Preview by clicking on the window and OSX will automatically reload the file with the new changes.  Errors in the compiled drawings will be shown in the drawing directly.

Some folks have good luck with Visual Studio and [this plugin](https://marketplace.visualstudio.com/items?itemName=EFanZh.graphviz-preview).  It's described in a blog post [here](https://spin.atomicobject.com/2017/11/15/table-rel-diagrams-graphviz/).

## Tips for WYSIWYG Editing (on Windows)

Someone with a Windows machine please add these instructions.

## Usage

The [repo](https://github.com/cisco-cx/docs-as-code) is a "template" repository. All you have to do is click the green "Use this template" button and instead of forking you can
make a totally new repository using it as a template. You can then just work in that new repo.

There's an example-template folder with a good working example.  The overall template is in common/pandoc/templates but the default is pretty usable. You will want to make your
own logo and drop it into common/images instead of the very ugly generic logo that we put there as a placeholder.

### Change the title in the Makefile

To change the title of the output document, change the OUT_NAME in the Makefile:

```
OUT_NAME := example-template
DIR_NAME := $(PWD)

include ../common/Makefile
```

### Setting the Document Attributes

To change the title, subtitle, and to control the various document attributes you can edit the "pp" directives in the main.md file:

```
---
title: The Title
subtitle: 0.1.0 - Confidentiality Statement Goes Here
author: ["First Author1", "Second Author2"]
titlepage: true
toc-title: Table of Contents
logo: ../common/images/logo.pdf
listings-disable-line-numbers: true
footer-left: 'Confidentiality Statement Goes Here'
!bash
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "date: Build Date $(date --iso-8601=date)"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
```

## Credits

The following folks did the heavy lifting on this effort:

[Josh Dotson](https://github.com/josdotso)
[David Wang](https://github.com/dcwangmit01)
[Hang Xie](https://github.com/hangxie)
