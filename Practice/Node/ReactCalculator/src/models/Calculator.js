import Scan from "./Scanner";

export default function Calculate(text) {
    var divisionByZero = false;
    var cursor = 0;
    let input = Scan(text);

    const Primary = () => {
        cursor++;
        return parseFloat(input[cursor-1]);
    }

    const Term = () => {
        var left = Primary();
        loop: while(cursor < input.length && !divisionByZero) {
            switch(input[cursor]) {
                case "*":
                    cursor++;
                    left *= Term();
                    break;
                case "/":
                    cursor++;
                    var right = Term();
                    if(right === 0) {
                        divisionByZero = true;
                        return;
                    }
                    left = parseFloat(left / right).toFixed(2);
                    break;
                case "+":
                    cursor++;
                    left += Term();
                    break;
                case "-":
                    cursor++;
                    left -= Term();
                    break;
                default:
                    break loop;
            }
        }
        return left;
    }

    var result = Term();
    return divisionByZero? "Division by Zero Error": parseFloat(result.toFixed(2));
}