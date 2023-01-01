function NavBar() {
    return (
      <nav className="navbar navbar-expand-lg bg-dark navbar-dark fixed-top">
          <div className='container'>
          <h1 className='navbar-brand'>Portfolio</h1>
          <button className='navbar-toggler' type="button" data-bs-toggle="collapse" data-bs-target="#navmenu">
          <span className='navbar-toggler-icon'></span></button>  
            <div className="collapse navbar-collapse" id="navmenu">
              <ul className="navbar-nav ms-auto">
                <NavItem icon="linkedin" alt="linkedin" link="https://www.linkedin.com/in/david-darigan-211b0a1b8/"/>
                <NavItem icon="github" alt="github" link="https://www.github.com/AlexDarigan"/>
                <NavItem icon="envelope" alt="email" link="mailto:david@darigan.dev"/>
              </ul>
            </div>
          </div>
        </nav>
    );
  }

  function NavItem({icon, alt, link}) {
    return (
        <li className='nav-item'><a href={link} className="nav-link">
            <i className={`bi bi-${icon}`} alt={alt}/></a>
        </li>
    )
  }
  
  export default NavBar;