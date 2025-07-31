from flask import Flask, request, jsonify, render_template
import psycopg2
import os

app = Flask(__name__)


DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql://franc:password@localhost:5432/example",
)


@app.route("/")
def index():
    """Render a list of all guests."""
    with psycopg2.connect(DATABASE_URL) as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM guests;")
            rows = cur.fetchall()
    return render_template("guests.html", guests=rows)

@app.route("/add", methods=["GET", "POST"])
def add():
    """Insert a new guest or display the form."""
    if request.method == "POST":
        data = request.form
        with psycopg2.connect(DATABASE_URL) as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "INSERT INTO guests (firstname, lastname) VALUES (%s, %s);",
                    (data["firstname"], data["lastname"]),
                )
                conn.commit()
        return jsonify({"status": "success"})
    else:
        return render_template("form.html")

if __name__ == "__main__":
    # Modo di sviluppo: autoreload e debug attivi
    app.run(host="0.0.0.0", port=5000, debug=True)
