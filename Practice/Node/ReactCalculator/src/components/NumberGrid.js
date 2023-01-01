import { useContext } from "react";
import { TextContext } from "../App";
import Button from "./Button";

const NumberGrid = () => {
    const numbers = "7894561230".split("");
    const { text, setText } = useContext(TextContext);

    const onNumberPressed = (number) => {
      setText(`${text}${number}`);
    } 

    return (
      <div className="Panel">
        {numbers.map((number) => (
          <Button key={number} value={number} onClick={onNumberPressed}/>
        ))}
      </div>
    )
}

export default NumberGrid;