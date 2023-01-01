from flask import Flask, render_template, url_for, redirect

app = Flask(__name__)


@app.get("/home")
@app.get("/")
def home():
    return render_template("home.html", title="Home")


@app.get("/cv")
def cv():
    return render_template("cv.html", title="CV")


@app.get("/interests")
def interests():
    return render_template("interests.html", title="Interests")


@app.get("/personal")
def personal():
    return render_template("personal.html", title="Personal Profile")


@app.get("/tech")
def tech():
    return render_template("tech.html", title="Computing Technologies")


# Redirects
@app.get("/wat")
def wat():
    return redirect("https://github.com/alexdarigan/wat", 301)


@app.get("/godotengine")
def godotengine():
    return redirect("https://www.godotengine.org", 301)


@app.get("/dockerhome")
def dockerhome():
    return redirect("https://www.docker.com/", 301)


@app.get("/composehome")
def composehome():
    return redirect("https://developer.android.com/jetpack/compose", 301)


# Tech Sub Page Routes
@app.get("/godot")
def godot():
    return render_template("tech/godot.html", title="Godot Technology")


# godot sub page routes
@app.get("/juan")
def juan():
    return redirect("https://www.linkedin.com/in/juan-linietsky-8a81203/", 301)


@app.get("/ariel")
def ariel():
    return redirect("https://www.linkedin.com/in/ariel-manzur-7b51263/", 301)


@app.get("/compose")
def compose():
    return render_template("tech/compose.html", title="Jetpack Compose Technology")


@app.get("/wattech")
def wattech():
    return render_template("tech/wat.html", title="WAT Technology")


if __name__ == "__main__":
    app.run(debug=True)
