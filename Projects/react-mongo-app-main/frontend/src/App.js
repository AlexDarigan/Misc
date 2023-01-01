import Nav from "./components/Nav";
import Home from "./pages/Home";
import RegisterForm from "./pages/Register";
import LoginForm from "./pages/Login";
import { BrowserRouter, Routes, Route } from "react-router-dom";


export default function App() {
  return (
    <BrowserRouter>
    <div className="App">
      <Nav/>
      <Routes>
        <Route path="/" element={<Home/>}/>
        <Route path="/register" element={<RegisterForm/>}/>
        <Route path="/login" element={<LoginForm/>}/>
      </Routes>
    </div>
    </BrowserRouter>
  );
}
