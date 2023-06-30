## Contributions are welcome!
To contribute:
- Make your changes
- Test everything affected
- Merge request
- Make any requested changes

You should follow the following rules:
- Tabs: 4 spaces
- Use ';' (semicolons) in JavaScript and functions
- Use meaningful comments
- Prefer easily understandable code rather than too many comments
- Avoid exceeding the width of 80 columns and NEVER over 120
- The structure:
```
function silly() {
    var i
    for (i = 10; i > 0; --i) {
        while (i > 8) {
            ++i;
            console.log("I: " + i)
            if (i > 20) 
                i = 7;
        }
        console.log("i: " +i)
    }
} 
```
- Spaces around operators:
` i = 0; ++i; i < 5; i != 8;`

### Don't know were to start from?
You can try solving some of the TODO. Find them like that:
` grep -rn "TODO" `
