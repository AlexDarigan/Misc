import { useState } from "react";
import { useNavigate } from "react-router-dom";
import FormInput from "./components/FormInput";

export default function RegisterForm() {

  const [username, setUserName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const navigate = useNavigate();

  function onUsernameChanged(e) {
    setUserName(e.target.value);
    console.log(e.target.value)
    console.log(username);
  }

  function onEmailChanged(e) {
    setEmail(e.target.value);
  }

  function onPasswordChanged(e) {
    setPassword(e.target.value);
  }

  function onConfirmPasswordChanged(e) {
    setConfirmPassword(e.target.value);
  }

  function onSubmit(e) {
    e.preventDefault();
    alert(`Hello ${username} with ${password} & ${confirmPassword} & email ${email}`);
    navigate("/");
  }

    return (
      <>
      <section>
        <h1><center>Register</center></h1>
      </section>
      <section>
      <form onSubmit={onSubmit}>
        <FormInput label="Username" type="text" value={username} onValueChanged={onUsernameChanged}/>
        <FormInput label="Email" type="email" value={email} onValueChanged={onEmailChanged}/>
        <FormInput label="Password" type="password" value={password} onValueChanged={onPasswordChanged}/>
        <FormInput label="Confirm Password" type="password" value={confirmPassword} onValueChanged={onConfirmPasswordChanged}/>
        <input type="submit" value="Submit"/>
      </form>
      </section>
      </>
    )
}

