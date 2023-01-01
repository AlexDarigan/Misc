import PropTypes from "prop-types";
import { TextContext } from "../App.js";
import { useContext } from "react";

const Display = () => {
  const { text, } = useContext(TextContext);

  return (
    <div className='Display'>
      <label>
        {text}
      </label>
    </div>
  )
}
  
export default Display;

Display.defaultProps = {
  text: "",
}

Display.propTypes = {
  text: PropTypes.string
}