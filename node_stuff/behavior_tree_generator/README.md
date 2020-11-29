```bash
node index.js | docker run -i think/plantuml > test.svg
```

```
node generate_diagram.js | docker run -i think/plantuml -tpng > diagram.png
```

```bash
docker run -d -p 8080:8080 plantuml/plantuml-server:jetty
```

```bash
node graphviz.js | dot -Tpng -o output.png
```