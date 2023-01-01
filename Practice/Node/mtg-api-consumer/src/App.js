import './App.css';
import { useState } from 'react';

function App() {
  const [text, setText] = useState("");
  const [imgUrl, setImgUrl] = useState("");

  const seek = () => {
    const fetchTasks = async() => {
      const res = await fetch(`https://api.magicthegathering.io/v1/cards/${text.toString()}`, {mode: "cors"});
      const data = await res.json();
      console.log(data);
      let url = data["card"]["imageUrl"].replace("http://", "https://");
      console.log(url);
      setImgUrl(url);
    }

    fetchTasks();
  }

  const onClicked = () => {
    console.log("Hello!");
  }

  const onChanged = (e) => {
    setText(e.target.value.toString());
    console.log(e.target.value);
  }

  return (
    <div className="App">
      <header className="App-header">
        <img src={imgUrl} alt="card img"/>
        <label>Hello World</label>
        <input type="text" onChange={onChanged} text="Hello World"/>
        <button onClick={seek}>Click Me</button>
        <button onClick={onClicked}>No Me!</button>
      </header>
    </div>
  );
}

export default App;
