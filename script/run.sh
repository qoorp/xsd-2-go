#! /bin/sh

TOP=$1
XSDTARGET=tmp

header() {
		echo package $1
		echo
		echo import '('
		echo \"encoding/xml\"
		echo
		echo \"$XSDTARGET/datatype\"
		echo ')'
		echo
}

TARGET=$GOPATH/src/$XSDTARGET

find $TOP -name package-info.class -exec rm '{}' ';'
DS=$(find $TOP -name '*.class' -exec dirname '{}' ';' | sort | uniq)
for d in $DS ; do
	last=$(basename $d)
	c=$(echo $d | tr '/' '.')
	t=$TARGET/$last
	mkdir -p $t
	f=$t/struct.go
	header $last > $f
	java -jar x2g.jar $d $c >> $f
done
