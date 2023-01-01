import PlaceholderImage from "../PlaceholderImg";

function Portfolio() {
    return (
      <section className="p-5">
          <div className='container expand-lg'>
            <div className="row text-center p-2">
              <div className="col-md"><Card title="WAT"/></div>
              <div className="col-md"><Card title="Remote Caller"/></div>
              <div className="col-md"><Card title="React Calculator"/></div>
            </div>
            <div className="row text-center p-2">
              <div className="col-md"><Card title="Java Crud"/></div>
              <div className="col-md"><Card title="Java Calculator"/></div>
              <div className="col-md"><Card title="API WIP"/></div>
            </div>
            <div className="row text-center p-2">
              <div className="col-md"><Card title="Prog Language"/></div>
              <div className="col-md"><Card title="Social Media Site"/></div>
              <div className="col-md"><Card title="WIP"/></div>
            </div>
          </div>
        </section>
    )
  }
  
  function Card({title}) {
    return (
      <div className="card bg-dark text-light">
      <center><PlaceholderImage/></center>
        <div class="card-body">
          <h6>{title}</h6>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore 
            magna aliqua. Semper auctor neque vitae tempus. Convallis a cras semper auctor</p>
          <a href={`https://www.github.com/alexdarigan/${title}`}><i className="bi bi-github"/></a>
        </div>
      </div>
    )
  }

  export default Portfolio;