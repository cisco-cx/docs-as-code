# Docs as Code

This is an example repo to enable Engineers to create documentation using markdown for text and PlantUML or Graphviz for drawings.  Those files are "compiled" to other formats (especially PDF).  The compiling tools are dockerized and automatically installed on first use.  You should not need to install anything other than docker.  Makefiles and Docker do all the work for you.

## Creating a New Document

### Fork and Branch

You should be working in your own forked copy of the master repository.

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

### Review Process

Documentation is treated the same way code is:  we review it through a pull request.  Create a pull request and have it reviewed.

## Building Docs

All currently built PDF documents are found in the `dist` directory. Changes to
the `dist` directory should always be in their own commit.

### Rebuilding current doc

To build, just:

```
make dist
```

Inspect the `dist` directory afterward.


## General Usage

```
$ make
build                          Build all doc directories
clean                          Clean all doc directories
dist                           Build all doc pdfs and copy them to ./dist directory
help                           Print list of Makefile targets
```

## Tips for WYSIWYG Editing (on a Mac)

Developers like the "edit-compile-test" loop which is not hard to do.  You can edit the source in one window using your favorite Editor that supports WYSIWYG (MacDown, Visual Studio Code) but seeing the drawings can require more work.  You can set up a local PlantUML server (instructions are easily findable with Google) but there is an easier way.

Edit the source in one window however you please.  Have a terminal open to the source repository root.  Use this to type "make dist" to compile to document to a PDF.

Have your output document open with your PDF output document (in the root dist folder).  When your compile is complete switch focus to Preview by clicking on the window and OSX will automatically reload the file with the new changes.  Errors in the compiled drawings will be shown in the drawing directly.

## Tips for WYSIWYG Editing (on Windows)

Someone with a Windows machine please add these instructions.
