import { Link } from "react-router-dom";

export default function Nav() {
    return (
      <>
      <nav className="navbar">
        <header>Your Page Name</header>
        <ul>
        <li><Link to="/login">Login</Link></li>
        <li><Link to="/register">Register</Link></li>
        <li><Link to="/">Home</Link></li>
        </ul>
      </nav>
      </>
    )
  }
  