xsd-2-go
========

Given a XSD (XML Schema Definition) file, generating corresponding Golang XML structs. 
This tool is written in Java.

1. Requirements
	* Java 1.6 or above.
	* XJC (Jaxb Binding Compiler) 
	* Maven

2. Background

Original xsd-2-go only seemed to handle one class. Refering to a type in another class made it stop.
This incarnation of xsd-2-go will handle multi-class XSD structures, provided the Java classes are unique in the last level. Ex: aktiekapital.aktiekapital_200 and aktiekapital.aktiekapital_210 is okay.
It will not add 'XML' first to all Go types. Keep an eye on types you want exported.

3. Usage
```
cd XSD_top_directory/..
xjc XSD_top_directory
Take note of the new Java source directory (ex: se/)
cd xsd-2-go/src/main/java/
ln -s XSD_top_directory/../se se
cd xsd-2-go
mvn compile
cd xsd-2-go/target/classes/
jar cfe x2g.jar main.Start .
xsd-2-go/script/run.sh se
```
That will create lots of directories in $GOPATH/src/tmp/, each with a struct.go file.
Now comes the tedious part. Copy the directory you need (with the struct.go file) to
the right place in your GOPATH. Try to build it. Copy directories that are missing. Etc.
All struct.go files have an import of datatype/. This is where you can put missing types.