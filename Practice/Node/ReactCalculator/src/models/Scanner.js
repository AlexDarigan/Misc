const Scan = (text) => {

    // Initialize
    var tokens = []
    var index = 0;
    var token = "";

    // Define Helpers
    const current = () => text[index]; 
    const isOperator = () => "+-/*".includes(current());
    const isNumeric = () => ('0' <= current() && current() <=  '9') || current() === '.';
    const isAtEnd = () => index >= text.length; 
    const advance = () => index++; 
    const commit = () => tokens.push(token);
    const clear = () => token = "";

    // Check for leading unary
    if(text[0] === "-") {
        token = "-";
        advance(); // IsNumericFails without an initial advance because "-" isn't a number
        while(!isAtEnd() && isNumeric()) {
            token += current();
            advance();
        }
        tokens.push(token);
    }

    // Scan
    while(!isAtEnd()) {
        clear();
        if(isOperator()) {
            tokens.push(current());
            advance();
            continue; 
        } 
        while(!isAtEnd() && isNumeric()) {
            token += current();
            advance();
        }
        commit();
    }

    if(text.length === 0) {
        tokens.push("0");
    }

    return tokens;
}

export default Scan;