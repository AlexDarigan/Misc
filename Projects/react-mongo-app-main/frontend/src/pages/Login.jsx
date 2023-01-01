import { useState } from "react";
import { useNavigate } from "react-router-dom";
import FormInput from "./components/FormInput";

export default function LoginForm() {
  const [username, setUserName] = useState("");
  const [password, setPassword] = useState("");
  const navigate = useNavigate();

  function onUsernameChanged(e) {
    setUserName(e.target.value);
  }

  function onPasswordChanged(e) {
    setPassword(e.target.value);
  }

  function onSubmit(e) {
    e.preventDefault();
    alert(`Hello ${username} with ${password}`);
    navigate("/");
  }

    return (
      <>
      <section>
        <h1><center>Login</center></h1>
      </section>
      <section>
      <form onSubmit={onSubmit}>
        <FormInput label="Username" type="text" value={username} onValueChanged={onUsernameChanged}/>
        <FormInput label="Password" type="password" value={password} onValueChanged={onPasswordChanged}/>
        <input type="submit" value="Submit"/>
      </form>
      </section>
      </>
    )
}
