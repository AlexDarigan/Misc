javac -cp ./src/main/java ./src/main/java/com/craftinginterpreters/lox/*.java -d ./out
jar cfvm Lox.jar ./src/main/resources/META-INF/MANIFEST.MF -C ./out/ .