const Button = ({value, onClick}) => <button onClick={() => onClick(value)}>{value}</button>

export default Button;