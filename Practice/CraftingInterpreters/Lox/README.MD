# Lox

This is Lox from Crafting Interpreters built in Java. I'll be using this README as an area to
store notes about the building process.

## Jar Files

Jar files are effectivelly a subset of Zip files that the Java runtime has a special
understanding of. 

The simplest command of creating a jar file is:

jar cf <jar-file> <input-file(s)> 

e.g jar cf MyJar.jar src/* 

"-c" or "--create" tells the Jar program that you want to create a jar file
"-f" or "--file" tells the Jar program that you want the output to go to an actually file (
    rather than STDOUT, that is the console output
)
"<jar-file>" is the name the jar will be given.  You can prepend a directory path if you want to save it
in a subdirectory. It is conventional to name it <name>.jar but it is not actually required.

<input-file(s)> is the files you want to package into Jar. In this example I used the wildcard * to include all files in
the src directory, but you can instead do something like <input-file-1> <input-file-2> <input-file-3> if you want something
more significant. When using the wildcard *, all files in subdirectories are added to the Jar as well.

// "-e" or "--main-class=<CLASSNAME>" tells the Jar Program where to start executing from when bundled.

Javac is the compiler and can be used to compile .java src files, to java.class files which are required to
to eventually make an executable jar file. You can use "javac -d 

## Basic Manifest File

    - META-INF/MANIFEST.MF
    - File is designed in Key-Value pair
    - File MUST end with a newline [VERY IMPORTANT]

// Compile
// Create
// Execute

// Compile
javac -d <output-directory> <input-directory>
e.g
javac -d target/classes src/main/java/*.java

// When specifying input directory, we need to make sure we're in the correct dir

jar cfe <MyJar.jar> <MainClass> <ClassInputFiles>

if we do <ClassInputFiles> as dirx/diry/*.class
Then we'll be checking for dirx/diry/Main for the main class

// QuickGuide

- Create Source Folder
- Create Classes Folder

Run "javac -d classes src/*.java" which will compile 
all .java classes in the src folder to .class files in the classes folder. If there are subdirectories in the src folder, they
will be created in the classes folder too."

Enter the classes folder and run

jar cfe <JarName.jar> <Package.MainClassName> <*.class>

This will create Jar inside that folder using Package.MainClassName as the EntryPoint and then *.class will add all .class
files in the classes directory recursively into the jar.

Then to run, you can use "java -jar <JarName.jar>"

Note: If you want to place the jar outside, you can use ../ in the jar name to travel back.

Class-Path means where our source files is stored? (in this case src/main/java) and any folder under java
is a package.

Our Manifest file gets copied into the .jar we create. This way it ends up referring to the .java files while in source,
but the copy that gets packed refer to the .class files that existed in the mirrored directory.

Can't use java filepath/*.java, if we require other java files.