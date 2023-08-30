#
set -e
set -x
reset=`pwd`
rm -rf antlr4
git clone https://github.com/opencastsoftware/antlr4.git
cd antlr4
git checkout  84866cc
# git checkout action-templates
git status .
git rev-parse --short HEAD
git rev-parse HEAD
export MAVEN_OPTS="-Xmx1G"
mvn clean
mvn -DskipTests install
whereisit=`pwd`/tool/target/antlr4-4.13.1-SNAPSHOT-complete.jar
whereisit=`cygpath -w $whereisit`
echo $whereisit
cd ..
rm -rf stg-python3
git clone https://github.com/kaby76/stg-python3
cd stg-python3
java --version
trgen --version
trgen -t Java
cd Generated-Java*
JAR="$whereisit"
CLASSPATH="$JAR\;."
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java   Python3Lexer.g4
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java   Python3Parser.g4
javac -cp "$CLASSPATH" *.java
java -cp "$CLASSPATH" Test small/constants.py
cd ..
rm -rf Generated-Java*
ls .
ls Java
set +e
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java -lib Java Python3Lexer.g4
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java -lib Java Python3Parser.g4
set -e
cd ..

echo DO OVER
cd "$reset"
pwd
rm -rf antlr4
git clone https://github.com/opencastsoftware/antlr4.git
cd antlr4
# git checkout  84866cc
git checkout action-templates
git status .
git rev-parse --short HEAD
git rev-parse HEAD
export MAVEN_OPTS="-Xmx1G"
mvn clean
mvn -DskipTests install
whereisit=`pwd`/tool/target/antlr4-4.13.1-SNAPSHOT-complete.jar
whereisit=`cygpath -w $whereisit`
echo $whereisit
cd ..
rm -rf stg-python3
git clone https://github.com/kaby76/stg-python3
cd stg-python3
java --version
trgen --version
trgen -t Java
cd Generated-Java*
JAR="$whereisit"
CLASSPATH="$JAR\;."
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java   Python3Lexer.g4
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java   Python3Parser.g4
javac -cp "$CLASSPATH" *.java
java -cp "$CLASSPATH" Test small/constants.py
cd ..
rm -rf Generated-Java*
ls .
ls Java
set +e
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java -lib Java Python3Lexer.g4
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java -lib Java Python3Parser.g4
set -e

echo DO OVER WITH FIX
cd "$reset"
pwd
rm -rf antlr4
git clone https://github.com/opencastsoftware/antlr4.git
cd antlr4
# git checkout  84866cc
git checkout action-templates
git status .
git rev-parse --short HEAD
git rev-parse HEAD
pushd tool/src/org/antlr/v4/tool/
patch  GrammarTransformPipeline.java "$reset/fix.txt"
popd
export MAVEN_OPTS="-Xmx1G"
mvn clean
mvn -DskipTests install
whereisit=`pwd`/tool/target/antlr4-4.13.1-SNAPSHOT-complete.jar
whereisit=`cygpath -w $whereisit`
echo $whereisit
cd ..
rm -rf stg-python3
git clone https://github.com/kaby76/stg-python3
cd stg-python3
java --version
trgen --version
trgen -t Java
cd Generated-Java*
JAR="$whereisit"
CLASSPATH="$JAR\;."
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java   Python3Lexer.g4
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java   Python3Parser.g4
javac -cp "$CLASSPATH" *.java
java -cp "$CLASSPATH" Test small/constants.py
cd ..
rm -rf Generated-Java*
ls .
ls Java
set +e
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java -lib Java Python3Lexer.g4
java -jar "$JAR" -encoding utf-8 -Dlanguage=Java -lib Java Python3Parser.g4
set -e
