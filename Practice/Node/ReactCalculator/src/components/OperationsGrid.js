import Button from "./Button";
import Calculate from "../models/Calculator";
import { useContext } from "react";
import { TextContext } from "../App";

const OperationsGrids = () => {
    const operators = "*/+".split("");
    const { text, setText } = useContext(TextContext);

    const IsOperator = (value) => !isNumber(value);
    const isNumber = (value) => '0' <= value && value <= '9'; 
    const onOpPressed = (op) => (text.length > 0 && !IsOperator(text.slice(-1))) && setText(text + op); 
    const onMinusPressed = (minusOp) => (text.length === 0 || isNumber(text.charAt(text.length-1))) && setText(text + minusOp)
    

    const onDecimalPressed = (decimal) => {
      // Cannot start with leading decimals
      if(text.length === 0 || !isNumber(text[text.length - 1])) { return; }

      // Prevent for immediate duplicates
      if(text[text.length - 1] === '.') { return; }
      
      for(var i = text.length - 1; i > 0 && isNumber([text[i]]); i--) {
        if(text[i - 1] === '.') { return; }
      }

      setText(text + decimal);
    }

    return (
      <div className='Panel'>
        {operators.map((operator) => (
          <Button key={operator} value={operator} onClick={onOpPressed}/>
        ))}
        <Button key="-" value={"-"} onClick={onMinusPressed}/>
        <Button key="." value={"."} onClick={onDecimalPressed}/>
        <Button key="=" value={"="} onClick={() => { setText(Calculate(text)) }}/>
        <Button key="<" value={"<"} onClick={() => setText(text.slice(0, -1))}/>
        <Button key="CLR" value={"CLEAR"} onClick={() => setText("")}/> 
      </div>
    )
}

export default OperationsGrids;