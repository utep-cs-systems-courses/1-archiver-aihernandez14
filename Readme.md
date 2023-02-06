# Introduction

For this project, you will create a toy archiver, much like the unix
program tar.

Tar was Unix' original tape archiver.  The original motivation for
creating tar was to enable the contents of multiple files to be stored
within a single tape in a manner that would enable those files to be
extracted later.  Tar's default output is stdout when storing, and
stdin when extracting.  A unix system's first tape drive is generally
accessible as /dev/mt0 (for Magnetic Tape zero), and therefore input
and output redirection can be used connect tar to it.

# Project Description.

Your job is to implement a new program named "mytar.py" that
implements tar's "c" (create) and x (extract) function.  

For example, the following command would "create" a new archive on
tape /dev/mt0 containing the files foo and goo.

`tar c foo goo > /dev/mt0`

And following command will extract the archived files on /dev/mt0 to
tar's current directory:

`tar x < /dev/mt0`

Note that, if foo or goo already exist, this extraction will overwrite
their contents.

Since tar relies on input and output redirection, it can also be used
to archive into a named file. For example, the following command will
save the contents of files foo and goo to a file named foogoo.tar:

`tar c foo goo > foogoo.tar`

And the following commands should copy src/foo.txt and src/goo.gif to
dest/foo and dest/goo:

`mkdir dest; (cd src; tar c foo.txt goo.gif) | (cd dest; tar x )`

# Important considerations and restrictions

__System call requirement:__
Your program should only perform i/o by explicitly calling posix
syscalls, as exposed in python's OS package. 

__Don't aspire to be compatible with the standard tar:__
The standard tar program implements many advanced features that are
not required for your archiver.  The encoding used by your program
will likely be very different 
(and incompatible) with the encodings used by the "standard" tar.

__File size__:
Your archive format may need to know file size (in bytes) before
copying its data.  If so, your program can determine this using either
lseek() and fstat() system calls. (also in the os package)


__Giant files:__
Note that the size of the files being archived may be greater than a
computer's address space.  Like both Unix's original the FSF herd's
current implementation of tar, your program should not require such a
large amount of memory.

__Binary files:__
Mytar.sh should be capable of copying the contents of
both plain-text and non-text "binary" files.

__Error reporting:__
Mytar.sh should report something useful (to stderr) if things run amuck.
For example, it should indicate if file or archive cannot be read or
or an archive's contents are obviously corrupted. 


# Keep it simple and exploit demo codes

Observe that mytar's c (create) mode should not create any new files.
Much like cat (and my demo cat.sh), it just reads from the files
provided as parameters and writes their contents (and, for my demo
version, their filenamess) to stdout.
 
Unlike cat, which just copies file contents verbatim, mytar in create
mode should encode and/or delimit those names and contents in a manner
that another instance of mytar running in x (extract) mode can
reliably distinguish and extract them.

You have been provided demo codes that open, create, close, read and
write files and stdion/out using only system calls exposed in python's os
package. Thus the project's only significant challenge will be
determine how to encode and/or delmit strings and bytearrays in an
archive's stream of bytes.  Once you figure this out, implementation
should be trivial.

# Documentation of Python's OS module.

It's all at [https://docs.python.org/3/library/io.html](https://docs.python.org/3/library/io.html).  Google also knows about "python.org os".

# A cool (and optional) feature 

If you want to do something extra, you might want to enable your
archiver to recursively archive entire directory hierarchies. 

If you want to implement this feature (seriously, do everything else
first), your program will need to use scandir() or listdir() to list
directory contents, and fstat() to determine whether a filename
actually is the name of a subdirectory.  These system calls are part of
the python os package.


# Testing your archiver

You have been provided a bash script "tar-test.sh" that uses tar to
copy the contents of a directory named src to a new directory named
dst.  It utilizes the herd utility program "diff" to compare
the contents of these two directories using its -r (for recursive)
option.  You may want to modify it to instead use mytar.sh.

# Learning outcomes

- file descriptors: can utilize in programs that read and write
  from stdin, stdout, stderr. and named files using system calls.

- interpreted programs: can construct interpreted programs that are
  invoked directly from the command line.  Includes familiarity with
  execute permission, shebang, and parameter passing via argv.

- framing: can implement programs that embed and extract multiple byte
  arrays containing variable sized binary (non-text) data within byte streams
  accessed via file descriptors.
  