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

## Creating a New Repo

If you would like to create a clone of this repo in a consistent way, please complete the following steps.

based on: https://help.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository

### Create a new GitHub repository (using GitHub)

Do NOT enable: "Initialize this repository with a README" - just create an empty repo (help is [here](https://help.github.com/en/github/getting-started-with-github/create-a-repo)).

```
git init
git remote add origin <insert the new git endpoint here>
```

Do NOT create a readme or any files.

### Create the folder for your desired new documentation repo

```
mkdir <folder name>
cd <folder name>
cd ..
```

### Create a bare clone of the example repo.

Make sure you are not in the <new folder> before you do this. 

```
git clone --bare git@github.com:cisco-sso/docs-as-code.git
```

### Mirror-push to your new docs repository.

Duplicate the example starting point repo into your new folder:

```
cd docs-as-code.git
git push --mirror <insert the new git endpoint here>
cd ..
```

### Cleanup and Update 

Remove the temporary local repository you created earlier:

```
rm -rf docs-as-code.git
```

Now pull the example contents into your new repo.  Note that you must state "origin" and "master" since your repo is completely bare.

```
cd <folder name>
git pull origin master
cd ..

```

### Logo

You probably want to change the logo for your document.  You will need a PDF.

```
cp <new logo pdf> common/images
```

You can either name your logo the detault "logo.pdf" or you can edit the main.md header to point to your new logo.

### Ready!

Your new docs repo should now be ready for use.

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
