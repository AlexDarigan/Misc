export default function FormInput({label, type, value, onValueChanged}) {
  return (
    <div className="form-group">
          <label htmlFor={label}>{label}</label>
          <input id={label} name={label} value={value} type={type} onChange={onValueChanged}/>
    </div>
  )
}