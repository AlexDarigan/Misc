import './App.css';
import Display from "./components/Display";
import Input from './components/Input';
import { createContext, useState } from 'react';

function App() {
  const [text, setDisplayText] = useState("");
  const setText = (text) => setDisplayText(text.toString());

  return (
    <div className="App">
      <TextContext.Provider value={{text, setText}}>
        <Display/>
        <Input/>
      </TextContext.Provider>
    </div>
  );
}

export default App;
export const TextContext = createContext(Text);
