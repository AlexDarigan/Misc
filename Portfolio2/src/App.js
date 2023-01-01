import PlaceholderImage from './PlaceholderImg';
import './App.css';
import NavBar from './components/Nav';
import Portfolio from './components/Portfolio';

function App() {
  return (
    <div>
      <NavBar/>
      <section className='bg-primary text-light p-5'>
        <div className='container pt-3'>

          <div class="d-sm-flex align-items-center justify-content-center">

          <PlaceholderImage/>
            <div>
              <h1><span className="text-warning">About Me</span></h1>
              <p className='lead m-4'>Hello I am A Developer. Yes. Quite right indeed.
              I am adding more text to see if this alignment works better with it. Feck.
              Why is everything horizontall aligned, where is my benetweh</p>
            </div>

            <div>
              <h1><span className="text-warning">Skills</span></h1>
              <p className='lead m-4'>Hello I am A Developer. Yes. Quite right indeed.
              I am adding more text to see if this alignment works better with it. Feck.
              Why is everything horizontall aligned, where is my benetweh</p>
            </div>

          </div>
        </div>
      </section>
      <Portfolio/>
    </div>
  );
}

export default App;

// About
// Skills
// Image